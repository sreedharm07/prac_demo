module "to_vpc" {
  source = "git::https://github.com/sreedharm07/tera-vpc.git"

  for_each         = var.vpc
  cidr             = each.value["cidr"]
  subnets          = each.value["subnets"]
  default_vpc_id   = var.default_vpc_id
  default_vpc_cidr = var.default_vpc_cidr
  vpc_default_id   = var.vpc_default_id
  tags             = var.tags
  env              = var.env
}

module "alb" {
  source              = "git::https://github.com/sreedharm07/tera-lb.git"
  for_each            = var.alb
  lb                  = each.value["internal"]
  lb-type             = each.value["lb-type"]
  tags                = var.tags
  env                 = var.env
  vpc_id              = each.value["internal"] ? local.vpc_id : var.default_vpc_id
  cidr-block          = each.value["cidr-block"]
  sg-port             = each.value["sg-port"]
  subnets             = each.value["internal"] ? local.subnets-ids : data.aws_subnets.example.ids
  certificate_arn_alb =var.certificate_arn_alb
}

module "docdb" {
  source = "git::https://github.com/sreedharm07/tf-docdb.git"
  tags   = var.tags
  env    = var.env

  for_each                = var.docdb
  subnet_ids              = local.db-ids
  engine_version          = each.value["engine_version"]
  master_username         = data.aws_ssm_parameter.username.value
  master_password         = data.aws_ssm_parameter.password.value
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  vpc_id                  = local.vpc_id
  sg-ingress-cidr         = local.subnets-apps-cidr
  instance_class          = each.value["instance_class"]
  kms_key_id = var.kms_key_id
}

module "rds" {
  for_each = var.rds_mysql

  source                  = "git::https://github.com/sreedharm07/tf-mysql.git"
  tags                    = var.tags
  env                     = var.env
  subnets_ids             = local.db-ids
  vpc_id                  = local.vpc_id
  sg-ingress-cidr         = local.subnets-apps-cidr
  sg_port                 = each.value["sg_port"]
  family                  = each.value["family"]
  backup_retention_period = each.value["backup_retention_period"]
  preferred_backup_window = each.value["preferred_backup_window"]
  engine_version          = each.value["engine_version"]
  engine                  = each.value["engine"]
  skip_final_snapshot     = each.value["skip_final_snapshot"]
  kms_key_id              = var.kms_key_id
}

module "redis" {
  source          = "git::https://github.com/sreedharm07/tf-elasticashe.git"
  for_each        = var.redis
  env             = var.env
  tags            = var.tags
  subnet_ids      = local.db-ids
  family          = each.value["family"]
  vpc_id          = local.vpc_id
  port            = each.value["port"]
  sg-ingress-cidr = local.subnets-apps-cidr
  engine          = each.value["engine"]
  engine_version  = each.value["engine_version"]
  node_type       = each.value["node_type"]
  num_cache_nodes = each.value["num_cache_nodes"]
}


module "rabbitmq" {
  source   = "git::https://github.com/sreedharm07/tf-rabbitmq.git"
  for_each = var.rabbitmq

  tags                = var.tags
  env                 = var.env
  vpc_id              = local.vpc_id
  sg-ingress-cidr     = local.subnets-apps-cidr
  port                = each.value["port"]
  sg-ssh-ingress-cidr = each.value["sg-ssh-ingress-cidr"]
  instance_type       = each.value["instance_type"]
  subnet_id           = local.db-ids
  kms_key_id          = var.kms_key_id
}


module "apps" {
  depends_on = [module.alb, module.to_vpc, module.docdb, module.rabbitmq, module.redis, module.rds]
  source   = "git::https://github.com/sreedharm07/tf-apps.git"
  for_each = var.apps


  components         = each.key
  instance_type      = each.value["instance_type"]
  image_id           = each.value["image_id"]
  desired_capacity   = each.value["desired_capacity"]
  max_size           = each.value["max_size"]
  min_size           = each.value["min_size"]
  priority           = each.value["priority"]
  port               = each.value["port"]
  parameters         = each.value["parameters"]
  sg-prometheus-cidr = var.sg-prometheus-cidr


  env                 = var.env
  tags                = merge(var.tags, each.value["tags"])
  sg-ssh-ingress-cidr = var.sg-ssh-ingress-cidr
  default_vpc         = var.default_vpc_id

  vpc_id          = local.vpc_id
  sg-ingress-cidr = local.subnets-apps-cidr
  subnet_ids      = local.subnets-ids
  dns_name        = local.dns_name
  listner         = local.listner
  dns_public_name = local.dns_public_name
  public_listner  = local.public_listner
  kms_key_id          = var.kms_key_id
}

resource "aws_instance" "load-runner" {
 ami = data.aws_ami.ami.id
  vpc_security_group_ids = ["sg-078ca100546627bbf"]
  instance_type = "t3.medium"
  tags = {
   Name = "load-runner"
  }
}