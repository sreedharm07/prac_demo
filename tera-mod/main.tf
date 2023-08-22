module "to_vpc" {
  source = "git::https://github.com/sreedharm07/tera-vpc.git"

 for_each = var.vpc
  cidr   = each.value["cidr"]
  subnets = each.value["subnets"]
  default_vpc_id=var.default_vpc_id
  default_vpc_cidr=var.default_vpc_cidr
  vpc_default_id=vpc_default_id
}

output "vpc" {
  value = module.to_vpc
}