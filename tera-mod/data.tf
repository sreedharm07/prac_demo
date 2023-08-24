data "aws_subnets" "example" {
  filter {
    name   = "vpc-id"
    values = [var.default_vpc_id]
  }
}

data "aws_ssm_parameter" "username" {
  name = "docdb-dev-username"
}

data "aws_ssm_parameter" "password" {
  name = "docdb-dev-password"
}