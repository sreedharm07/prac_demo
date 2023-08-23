vpc= {
  main = {
    cidr    = "10.0.0.0/16"
    subnets = {
      public = {
        public1 = { cidr = "10.0.0.0/24", az = "us-east-1a" }
        public2 = { cidr = "10.0.1.0/24", az = "us-east-1b" }
      }
      app = {
        app1 = { cidr = "10.0.2.0/24", az = "us-east-1a" }
        app2 = { cidr = "10.0.3.0/24", az = "us-east-1b" }
      }
      db = {
        db1 = { cidr = "10.0.4.0/24", az = "us-east-1a" }
        db2 = { cidr = "10.0.5.0/24", az = "us-east-1b" }
      }
    }
  }
}


default_vpc_id="vpc-0a3c5f7ee27b6f4c9"
default_vpc_cidr="172.31.0.0/16"
vpc_default_id="rtb-07cea716b496e4fc7"

tags= {
  company      = "abc"
  created_by   = "terraform"
  landing_zone = "xyz"
}
env="dev"


alb= {
  private = {
    internal   = "true"
    lb-type    = "application"
    cidr-block = ["172.31.0.0/16", "10.0.0.0/16"]
    sg-port= "80"
  }

  public = {
    internal   = "false"
    lb-type    = "application"
    cidr-block = ["0.0.0.0/0"]
    sg-port= "80"
  }
}


docdb={
  main={


  }
}