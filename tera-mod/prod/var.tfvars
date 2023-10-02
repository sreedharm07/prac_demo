vpc= {
  main = {
    cidr    = "10.50.0.0/16"
    subnets = {
      public = {
        public1 = { cidr = "10.50.0.0/24", az = "us-east-1a" }
        public2 = { cidr = "10.50.1.0/24", az = "us-east-1b" }
      }
      app = {
        app1 = { cidr = "10.50.2.0/24", az = "us-east-1a" }
        app2 = { cidr = "10.50.3.0/24", az = "us-east-1b" }
      }
      db = {
        db1 = { cidr = "10.50.4.0/24", az = "us-east-1a" }
        db2 = { cidr = "10.50.5.0/24", az = "us-east-1b" }
      }
    }
  }
}
kms_key_id   = "arn:aws:kms:us-east-1:120752001195:key/90368eb1-f0ed-4e4f-bd9f-5c38abef1dd7"
sg-prometheus-cidr=  "172.31.44.187/32"

default_vpc_id="vpc-0a3c5f7ee27b6f4c9"
default_vpc_cidr="172.31.0.0/16"
vpc_default_id="rtb-07cea716b496e4fc7"

tags= {
  company      = "abc"
  created_by   = "terraform"
  landing_zone = "xyz"
}
env="prod"

certificate_arn_alb="arn:aws:acm:us-east-1:120752001195:certificate/2a001ae5-6779-4bd2-b99f-e40d9b274713"

alb= {
  private = {
    internal   = "true"
    lb-type    = "application"
    cidr-block = ["172.31.0.0/16", "10.50.0.0/16"]
    sg-port    = "80"
  }

  public = {
    internal   = "false"
    lb-type    = "application"
    cidr-block = ["0.0.0.0/0"]
    sg-port    = "443"
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


sg-ssh-ingress-cidr= "172.31.16.231/32"
rabbitmq = {
  main = {
    port                = 5672
    sg-ssh-ingress-cidr = "172.31.16.231/32"
    instance_type       = "t3.micro"
  }
}

apps= {
  frontend = {
    instance_type    = "t3.micro"
    image_id         = "ami-0899db80f06ad7854"
    desired_capacity = 2
    max_size         = 10
    min_size         = 2
    priority         = 1
    port             = 80
    parameters       = ["nexus"]
    tags             = { nginx-monitor = "yes" }
  }
  catalogue = {
    instance_type    = "t3.micro"
    image_id         = "ami-0899db80f06ad7854"
    desired_capacity = 2
    max_size         = 10
    min_size         = 2
    priority         = 2
    port             = 8080
    parameters       = ["db", "nexus"]
    tags             = {}
  }
  user = {
    instance_type    = "t3.micro"
    image_id         = "ami-0899db80f06ad7854"
    desired_capacity = 2
    max_size         = 10
    min_size         = 2
    priority         = 3
    port             = 8080
    parameters       = ["db","nexus"]
    tags             = {}
  }

  cart = {
    instance_type    = "t3.micro"
    image_id         = "ami-0899db80f06ad7854"
    desired_capacity = 2
    max_size         = 10
    min_size         = 2
    priority         = 4
    port             = 8080
    parameters       = ["nexus"]
    tags             = {}

  }
  payment = {
    instance_type    = "t3.micro"
    image_id         = "ami-0899db80f06ad7854"
    desired_capacity = 2
    max_size         = 10
    min_size         = 2
    priority         = 5
    port             = 8080
    parameters       = ["rabbitmq" , "nexus"]
    tags             = {}

  }
  shipping = {
    instance_type    = "t3.small"
    image_id         = "ami-0899db80f06ad7854"
    desired_capacity = 2
    max_size         = 10
    min_size         = 2
    priority         = 6
    port             = 8080
    parameters       = ["nexus"]
    tags             = {}

  }
  dispatch = {
    instance_type    = "t3.micro"
    image_id         = "ami-0899db80f06ad7854"
    desired_capacity = 2
    max_size         = 10
    min_size         = 2
    priority         = 7
    port             = 8080
    parameters       = ["dispatch", "nexus"]
    tags             = {}

  }
}




