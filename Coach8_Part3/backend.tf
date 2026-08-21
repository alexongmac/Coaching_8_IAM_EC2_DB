terraform {
  backend "s3" {
    bucket  = "sctp-tfstate-ce13"
    key     = "alex-Coach8"
    region  = "us-east-1"
    encrypt = true
  }
}