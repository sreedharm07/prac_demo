resource "aws_vpc" "vpc" {
  for_each = var.vpc
  cidr_block = each.value["cidr"]
}

resource "aws_subnet" "main" {
  for_each = var.vpc.value["subnets"]
  vpc_id     = aws_vpc.vpc
  cidr_block = each.value["cidr"]

  tags = {
    Name = each.key
  }
}