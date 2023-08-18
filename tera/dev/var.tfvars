instance_type= "t3.micro"
security_group= "sg-03c71c5d008981a14"

components= {
  redis     = {name="redis"}
  frontend  = { name = "frontend" }
  mongodb   = { name = "mongodb" }
  catalogue = { name = "catalogue" }
}