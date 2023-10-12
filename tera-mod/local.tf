locals {
  vpc_id= lookup(lookup(module.to_vpc, "main", null), "vpc_id", null)

  subnets-ids = [for k,v in lookup(lookup(lookup(lookup(module.to_vpc, "main",null ),"subnet",null),"app",null),"subnets",null) : v.id]
  db-ids = [for k,v in lookup(lookup(lookup(lookup(module.to_vpc, "main",null ),"subnet",null),"db",null),"subnets",null) : v.id]

  subnets-apps-cidr = [for k,v in lookup(lookup(lookup(lookup(module.to_vpc, "main",null ),"subnet",null),"app",null),"subnets",null) : v.cidr_block]


#  dns_name= lookup(lookup(lookup(module.alb,"private",null ),"alb",null),"dns_name",null)
#  dns_public_name= lookup(lookup(lookup(module.alb,"public",null ),"alb",null),"dns_name",null)
#
#  listner= lookup(lookup(lookup(module.alb,"private",null ),"listner",null),"arn",null)
#  public_listner= lookup(lookup(lookup(module.alb,"public",null ),"listner",null),"arn",null)

}