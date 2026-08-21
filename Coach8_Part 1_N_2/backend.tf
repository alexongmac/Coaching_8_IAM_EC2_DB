terraform {
  backend "s3" {
    bucket  = "sctp-tfstate-ce13"
    key     = "alexongCoach8/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
