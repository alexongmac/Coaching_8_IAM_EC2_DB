locals {
  name_prefix = "${var.name_prefix}-coach8"
  environment = var.environment
}

resource "aws_iam_role" "role" {
  name = "${local.name_prefix}-role"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Sid    = ""
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    tag-key = "alex-role"
  }

}
# Option 1: This is the preferred way to create an IAM policy using a data block. It allows for more complex policies and is easier to read and maintain. The policy document is defined in the data block and then referenced in the aws_iam_policy resource.
data "aws_iam_policy_document" "policy" {
 statement {
   effect    = "Allow"
   actions   = ["ec2:Describe*"]
   resources = ["*"]
 }
 statement {
   effect    = "Allow"
   actions   = ["s3:ListBucket", "s3:ListAllMyBuckets"]
   resources = ["*"]
 }

  statement {
    effect    = "Allow"
    actions   = ["dynamodb:ListTables"]
    resources = ["*"]
  }
  statement {
    effect    = "Allow"
    actions   = ["dynamodb:Scan"]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "policy" {
  name = "${local.name_prefix}-policy"
  policy = data.aws_iam_policy_document.policy.json

}

resource "aws_iam_role_policy_attachment" "attach" {
  role       = aws_iam_role.role.name
  policy_arn = aws_iam_policy.policy.arn
}

resource "aws_iam_instance_profile" "profile" {
  name = "${local.name_prefix}-profile"
  role = aws_iam_role.role.name
}

###########################################
## EC2 instance
###########################################

resource "aws_instance" "ec2" {
  ami                         = data.aws_ami.al_mi.id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = data.aws_subnets.public.ids[0]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.profile.name
  vpc_security_group_ids      = [aws_security_group.allow_ssh.id]


  tags = {
    Name = "${local.name_prefix}-instance"
  }
}

resource "aws_security_group" "allow_ssh" {
  name        = "${local.name_prefix}-sg"
  description = "Allow SSH inbound traffic"
  vpc_id      = data.aws_vpc.selected.id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${local.name_prefix}-sg"
  }
}

