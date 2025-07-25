#route53.tf

# Look up your hosted zone for devopsjames.com
data "aws_route53_zone" "primary" {
  name         = "devopsjames.com"
  private_zone = false
}

# Create A record (alias) pointing to your ALB
resource "aws_route53_record" "root_domain" {
  zone_id = data.aws_route53_zone.primary.zone_id
  name    = "${var.environment}.devopsjames.com"
  type    = "A"

  alias {
    name                   = aws_lb.flask_alb.dns_name
    zone_id                = aws_lb.flask_alb.zone_id
    evaluate_target_health = true
  }
}
