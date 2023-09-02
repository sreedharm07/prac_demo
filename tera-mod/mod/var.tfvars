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

#sg-prometheus-cidr=  " "

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
    sg-port    = "80"
  }

  public = {
    internal   = "false"
    lb-type    = "application"
    cidr-block = ["0.0.0.0/0"]
    sg-port    = "80"
  }
}


docdb= {
  main = {
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    skip_final_snapshot     = true
    engine_version          = "4.0.0"
    instance_class          = "db.t3.medium"
  }
}

rds_mysql= {
  main = {
    sg_port                 = 3306
    family                  = "aurora-mysql5.7"
    backup_retention_period = 5
    preferred_backup_window = "07:00-09:00"
    engine_version          = "5.7.mysql_aurora.2.11.3"
    engine                  = "aurora-mysql"
    skip_final_snapshot     = true
  }
}

redis= {
  main = {
    family          = "redis6.x"
    port            = 6379
    engine          = "redis"
    engine_version  = "6.2"
    node_type       = "cache.t2.micro"
    num_cache_nodes = 1
  }
}


sg-ssh-ingress-cidr= "172.31.88.78/32"
rabbitmq = {
  main = {
    port                = 5672
    sg-ssh-ingress-cidr = "172.31.88.78/32"
    instance_type       = "t3.micro"
  }
}

apps= {
  frontend = {
    instance_type    = "t3.micro"
    image_id         = "ami-03265a0778a880afb"
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    priority         = 1
    port             = 80
    parameters       = []
  }
  catalogue = {
    instance_type    = "t3.micro"
    image_id         = "ami-03265a0778a880afb"
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    priority         = 2
    port             = 8080
    parameters       = ["db"]
  }
  user = {
    instance_type    = "t3.micro"
    image_id         = "ami-03265a0778a880afb"
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    priority         = 3
    port             = 8080
    parameters       = ["db"]
  }
  cart = {
    instance_type    = "t3.micro"
    image_id         = "ami-03265a0778a880afb"
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    priority         = 4
    port             = 8080
    parameters       = []
  }
  payment = {
    instance_type    = "t3.micro"
    image_id         = "ami-03265a0778a880afb"
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    priority         = 5
    port             = 8080
    parameters       = ["rabbitmq"]
  }
  shipping = {
    instance_type    = "t3.micro"
    image_id         = "ami-03265a0778a880afb"
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    priority         = 6
    port             = 8080
    parameters       = []
  }
  dispatch = {
    instance_type    = "t3.micro"
    image_id         = "ami-03265a0778a880afb"
    desired_capacity = 1
    max_size         = 3
    min_size         = 1
    priority         = 7
    port             = 8080
    parameters       = ["dispatch"]
  }
}

#sample ffile