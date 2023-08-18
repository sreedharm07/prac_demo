module "resource" {
  source = "./modules"

  for_each = var.components

  instance_type = var.instance_type
  security_group= var.security_group
  zone_id=var.zone_id
  components = each.key

}