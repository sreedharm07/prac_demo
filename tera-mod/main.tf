module "vpc" {
  source = "git::https://github.com/sreedharm07/tera-vpc.git"

  for_each = var.vpc
  cidr= each.value["cidr"]
  subnets= each.value["subnets"]
}
