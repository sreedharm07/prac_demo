resource "aws_instance" "instance" {
  ami            = data.aws_ami.ami.id
  instance_type  = var.instance_type
  vpc_security_group_ids =  [var.security_group]

  tags = {
    Name           = var.components
  }
}


resource "aws_route53_record" "record" {
  zone_id = var.zone_id
  name    = "${var.components}.cloudev7.online"
  type    = "A"
  ttl     = 30
#  records = [aws_instance.instance[each.key].private_ip](when we give liip in route 53
  records = [aws_instance.instance.private_ip]
}


