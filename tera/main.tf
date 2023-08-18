resource "aws_instance" "instance" {
  ami            = data.aws_ami.ami.id
  instance_type  = var.instance_type
  vpc_security_group_ids =  [var.security_group]

  for_each        = var.components
  tags = {
    Name           = each.key
  }
}

resource "aws_route53_record" "record" {
  zone_id = var.zone_id
  name    = "${var.components}-dev"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.id]
}
