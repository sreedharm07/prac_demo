locals {
  vpc_id= lookup(lookup(module.to_vpc, "main", null), "vpc_id", null)

  subnets-ids = [for k,v in lookup(lookup(lookup(lookup(module.to_vpc, "main",null ),"subnet",null),"app",null),"subnets",null) : v.id]
  db-ids = [for k,v in lookup(lookup(lookup(lookup(module.to_vpc, "main",null ),"subnet",null),"db",null),"subnets",null) : v.id]

  subnets-apps-cidr = [for k,v in lookup(lookup(lookup(lookup(module.to_vpc, "main",null ),"subnet",null),"app",null),"subnets",null) : v.cidr_block]

}