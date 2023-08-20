vpc={
  main={
    cidr= "10.0.0.0/16"
    subnets={
      public={
        pb1={cidr="10.0.0.0/24" , az= "us-east-1a"}
        pb2={cidr="10.0.1.0/24" , az= "us-east-1b"}
      }
    }
  }
}