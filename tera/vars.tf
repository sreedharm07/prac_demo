#variable "instance_type" {
#  default = "t3.micro"
#}
#variable "security_group" {
#  default = "sg-03c71c5d008981a14"
#}
#variable "zone_id" {
#  default = "Z07380001ED1GOXY0KMLD"
#}
#variable "components" {
#  default = {
#    frontend  = { name = "frontend" }
#    mongodb   = { name = "mongodb" }
#    catalogue = { name = "catalogue" }
#    redis     = { name = "redis" }
#    user      = { name = "user" }
#    cart      = { name = "cart" }
#    mysql     = { name = "mysql" }
#    rabbitmq  = { name = "rabbitmq" }
#    shipping  = { name = "shipping" }
#    payment   = { name = "payment" }
#    dispatch  = { name = "dispatch" }
#  }
#}]]]]]]

variable "instance_type" {}
variable "security_group" {}
variable "zone_id" {}
variable "components" {}