#main.tf test environement (use `../..` to point to root terraform dierctory infra)

module "app_stack" {
  source = "../../"

  acm_certificate_arn = var.acm_certificate_arn
  image_tag           = var.image_tag
  environment         = "prod"
}
