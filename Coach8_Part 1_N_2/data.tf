data "aws_vpc" "selected" {

  filter {
    name   = "tag:Name"
    values = ["sctp-vpc-ce13"]
  }
}

data "aws_ami" "al_mi" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023*x86_64"] # $ aws ec2 describe-images --image-ids ami-02b64aa047cb5edf5  
  }
}

data "aws_subnets" "public" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.selected.id]
  }

  filter {
    name   = "tag:Name"
    values = ["*public*"]
  }

  # A subnet is only truly public if it auto-assigns public IPs (and routes via an IGW).
  # This guards against a subnet that is merely *named* "public".
  filter {
    name   = "map-public-ip-on-launch"
    values = ["true"]
  }
}

