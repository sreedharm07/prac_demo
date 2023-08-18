terraform {
  backend "s3" {
    bucket = "omg7"
    key    = "dev/state.tf"
    region = "us-east-1"
  }
}
