# =========================
# ACM Certificate Management
# =========================

# Create ACM only in prod
resource "aws_acm_certificate" "root_and_wildcard" {
  count = var.environment == "prod" ? 1 : 0

  domain_name               = "devopsjames.com"
  subject_alternative_names = ["*.devopsjames.com"]
  validation_method         = "DNS"

  tags = {
    Name        = "root-and-wildcard-devopsjames"
    Environment = "shared"
  }

  lifecycle {
    create_before_destroy = true
  }
}

# DNS validation (prod only)
resource "aws_route53_record" "root_and_wildcard_validation" {
  for_each = var.environment == "prod" ? {
    for dvo in aws_acm_certificate.root_and_wildcard[0].domain_validation_options : dvo.domain_name => {
      name   = dvo.resource_record_name
      type   = dvo.resource_record_type
      record = dvo.resource_record_value
    }
  } : {}

  zone_id = data.aws_route53_zone.primary.zone_id
  name    = each.value.name
  type    = each.value.type
  ttl     = 60
  records = [each.value.record]
}

# Validate ACM certificate (prod only)
resource "aws_acm_certificate_validation" "root_and_wildcard" {
  count = var.environment == "prod" ? 1 : 0

  certificate_arn         = aws_acm_certificate.root_and_wildcard[0].arn
  validation_record_fqdns = [for record in aws_route53_record.root_and_wildcard_validation : record.fqdn]
}

# For non-prod, read existing ACM certificate
data "aws_acm_certificate" "existing" {
  count       = var.environment != "prod" ? 1 : 0
  domain      = "*.devopsjames.com"
  statuses    = ["ISSUED"]
  most_recent = true
}
