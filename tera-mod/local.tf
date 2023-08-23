locals {
  vpc_id=lookup(lookup(module.to_vpc, "main", null), "vpc_id", null)

  subnets-ids = lookup(lookup(lookup(lookup(module.to_vpc, "main",null ),"subnet",null),"app",null),"subnets",null)




}