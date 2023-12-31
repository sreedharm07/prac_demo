variable "vpc" {}
variable "default_vpc_id" {}
variable "default_vpc_cidr" {}
variable "vpc_default_id" {}
variable "tags" {}
variable "env" {}
variable "alb" {}
variable "docdb" {}
variable "rds_mysql" {}

variable "redis" {}

variable "rabbitmq" {}

variable "apps" {}
variable "sg-ssh-ingress-cidr" {}
variable "sg-prometheus-cidr" {}
variable "certificate_arn_alb" {}
variable "kms_key_id" {}