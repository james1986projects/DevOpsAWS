module "app_stack" {
  source = "../../"

  acm_certificate_arn = var.acm_certificate_arn
  image_tag           = var.image_tag
  environment         = var.environment
}