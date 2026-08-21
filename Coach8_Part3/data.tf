data "aws_vpc" "selected" {
  filter {
    name   = "tag:Name"
    values = ["sctp-vpc-ce13"]
  }
}

data "aws_subnet" "selected" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["sctp-vpc-ce13-public-*-1a"]
  }
}

data "aws_subnet" "db1_selected" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["sctp-vpc-ce13-db-*-1a"]
  }
}

data "aws_subnet" "db2_selected" {
  vpc_id = data.aws_vpc.selected.id
  filter {
    name   = "tag:Name"
    values = ["sctp-vpc-ce13-db-*-1b"]
  }
}

data "aws_ami" "al_ami" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-6.1-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]

  }
}