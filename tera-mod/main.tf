module "to_vpc" {
  source = "git::https://github.com/sreedharm07/tera-vpc.git"

 for_each = var.vpc
  cidr   = each.value["cidr"]
  subnets = each.value["subnets"]
  default_vpc_id=var.default_vpc_id
  default_vpc_cidr=var.default_vpc_cidr
  vpc_default_id=var.vpc_default_id
  tags=  var.tags
  env =var.env

}

module "alb" {
  source     = "git::https://github.com/sreedharm07/tera-lb.git"
  for_each   = var.alb
  lb         = each.value["internal"]
  lb-type    = each.value["lb-type"]
  tags       = var.tags
  env        = var.env
  vpc_id     = each.value["internal"] ? local.vpc_id : var.vpc_default_id
  cidr-block = each.value["cidr-block"]
  sg-port    = each.value["sg-port"]
  subnets    = each.value["internal"] ? local.subnets-ids : data.aws_subnets.example.ids

}



output "vpc" {
  value = local.vpc_id
}