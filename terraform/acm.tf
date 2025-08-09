# acm.tf

#############################
# PROD: create apex + wildcard cert
#############################
resource "aws_acm_certificate" "root_and_wildcard" {
  count                     = var.environment == "prod" ? 1 : 0
  domain_name               = "devopsjames.com"
  subject_alternative_names = ["*.devopsjames.com"]
  validation_method         = "DNS"

  tags = {
    Name        = "root-and-wildcard-devopsjames"
    Environment = "prod"
  }

  lifecycle {
    create_before_destroy = true
  }
}

#############################
# Dedupe validation options by CNAME name
# (ACM often returns the SAME CNAME for root and wildcard)
#############################
locals {
  dvo_grouped = var.environment == "prod" ? {
    for name, list in {
      for dvo in aws_acm_certificate.root_and_wildcard[0].domain_validation_options :
      dvo.resource_record_name => dvo...
    } : name => list[0]
  } : {}
}

#####################################
# PROD: DNS validation records (deduped)
#####################################
resource "aws_route53_record" "root_and_wildcard_validation" {
  for_each        = local.dvo_grouped
  zone_id         = data.aws_route53_zone.primary.zone_id
  name            = each.value.resource_record_name
  type            = each.value.resource_record_type
  ttl             = 60
  allow_overwrite = true
  records         = [each.value.resource_record_value]
}

#####################################
# PROD: complete validation after DNS records exist
#####################################
resource "aws_acm_certificate_validation" "root_and_wildcard" {
  count                   = var.environment == "prod" ? 1 : 0
  certificate_arn         = aws_acm_certificate.root_and_wildcard[0].arn
  validation_record_fqdns = [for r in values(aws_route53_record.root_and_wildcard_validation) : r.fqdn]
}

#####################################
# NON-PROD: look up an existing issued wildcard cert
#####################################
data "aws_acm_certificate" "existing" {
  count       = var.environment != "prod" ? 1 : 0
  domain      = "*.devopsjames.com"
  statuses    = ["ISSUED"]
  most_recent = true
}
