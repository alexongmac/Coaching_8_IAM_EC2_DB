variable "name_prefix" {
  description = "Prefix for naming resources"
  type        = string
  default     = "alex"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
  default     = "alex-key-pair"
}

variable "environment" {
  description = "Environment name applied to resource tags"
  type        = string
  default     = "dev"
}