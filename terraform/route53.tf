# Look up your hosted zone for devopsjames.com
data "aws_route53_zone" "primary" {
  name         = "devopsjames.com"
  private_zone = false
}

# Only create the root domain record in prod
resource "aws_route53_record" "root_domain_root" {
  count   = var.environment == "prod" ? 1 : 0
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "devopsjames.com"
  type    = "A"

  alias {
    name                   = aws_lb.flask_alb.dns_name
    zone_id                = aws_lb.flask_alb.zone_id
    evaluate_target_health = true
  }
}

# Always create environment-specific subdomain (e.g., test.devopsjames.com)
resource "aws_route53_record" "root_domain" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name = "devopsjames.com"

  type    = "A"

  alias {
    name                   = aws_lb.flask_alb.dns_name
    zone_id                = aws_lb.flask_alb.zone_id
    evaluate_target_health = true
  }
}
