module "vpc" {
  source = "git::https://github.com/sreedharm07/tera-vpc.git"


  cidr= var.vpc["cidr"]
  subnets=var.vpc["sunets"]
}