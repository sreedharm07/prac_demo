resource "aws_vpc" "vpc" {
  for_each = var.vpc
  cidr_block = each.value["cidr"]
}
