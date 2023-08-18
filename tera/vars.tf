#variable "instance_type" {}
#variable "security_group" {}
#variable "components" {}
#variable "zone_id" {}


variable "instance_type" {
  default = "t3.micro"
}
variable "security_group" {
  default = "sg-03c71c5d008981a14"
}
variable "zone_id" {
  default = "Z07380001ED1GOXY0KMLD"
}
variable "components" {
  default = {
    components = {
      frontend  = { name = "frontend" }
      mongodb   = { name = "mongodb" }
      catalogue = { name = "catalogue" }
      redis     = { name = "redis" }
    }
  }
}
