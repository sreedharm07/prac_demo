resource "aws_vpc" "vpc" {
  for_each = var.cidr
  cidr_block = each.value
}
