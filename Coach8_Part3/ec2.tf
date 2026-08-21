module "ec2_instance" {
  source = "terraform-aws-modules/ec2-instance/aws"

  name                        = "${var.name}-${var.environment}-ec2-coach8-3"
  ami                         = data.aws_ami.al_ami.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = true
  monitoring                  = true

  subnet_id = data.aws_subnet.selected.id

  create_security_group  = false
  vpc_security_group_ids = [module.ec2_security_group.id]

  tags = {
    Name = "${var.name}-${var.environment}-ec2-coach8-3"
  }

}

module "ec2_security_group" {
  source = "terraform-aws-modules/security-group/aws"

  name        = "${var.name}-${var.environment}-sg-coach8-3"
  description = "Security group for ${var.name}-${var.environment}-ec2-coach8-3"
  vpc_id      = data.aws_vpc.selected.id

  ingress_rules = {
    ssh = {
      description = "Allow SSH access"
      from_port   = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }

    http = {
      description = "Allow HTTP access"
      from_port   = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }

    self-all = {
      ip_protocol                  = "-1"
      referenced_security_group_id = "self"
      description                  = "All traffic from members of this SG"
    }
  }

  egress_rules = {
    all = {
      description = "Allow all outbound traffic"
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }

  tags = {
    Environment = var.environment
  }
}