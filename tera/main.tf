resource "aws_instance" "instance" {
  ami           = data.aws_ami.ami.id
  instance_type = var.instance_type
  security_groups=  [var.security_group]

  for_each = var.components
  tags = {
    Name = each.key
  }
}