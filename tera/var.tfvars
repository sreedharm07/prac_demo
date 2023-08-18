instance_type= "t3.micro"
security_group= "sg-03c71c5d008981a14"
zone_id= "Z07380001ED1GOXY0KMLD"


components= {
  frontend  = { name = "frontend" }
  mongodb   = { name = "mongodb" }
  catalogue = { name = "catalogue" }
  redis     = {name="redis"}
}