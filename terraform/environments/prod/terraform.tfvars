environment          = "prod"
region               = "us-east-1"
domain_name          = "devopsjames.com"
subdomain            = "www"

ecs_desired_count    = 2
ecs_min_capacity     = 2
ecs_max_capacity     = 4
container_cpu        = 512
container_memory     = 1024
acm_certificate_arn = "arn:aws:acm:us-east-1:124482837913:certificate/8d315c5b-a06a-4b2e-91b4-a666c934e763"
