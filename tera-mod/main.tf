module "vpc" {
  source = "git::https://github.com/sreedharm07/tera-vpc.git"

  for_each = var.vpc
  cidr=each.value["cidr"]
  subnets=each.value["subnets"]
  default_vpc=var.default_vpc
  default_route_id=var.default_route_id
  default_vpc_route_id=default_vpc_route_id
}


output "vpc" {
  value = module.vpc
}