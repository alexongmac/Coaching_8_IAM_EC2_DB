##############################
# RDS
##############################

output "db_instance_endpoint" {
  description = "Connection endpoint for the RDS instance (host:port)"
  value       = module.rds.db_instance_endpoint
}

output "db_instance_port" {
  description = "Port the database is listening on"
  value       = module.rds.db_instance_port
}

output "db_instance_username" {
  description = "Master username for the database"
  value       = module.rds.db_instance_username
  sensitive   = true
}

output "db_instance_identifier" {
  description = "RDS instance identifier"
  value       = module.rds.db_instance_identifier
}

# ARN of the Secrets Manager secret holding the generated master password.
# Retrieve the password with:
#   aws secretsmanager get-secret-value --region <region> \
#     --secret-id <this-arn> --query SecretString --output text
output "db_master_user_secret_arn" {
  description = "ARN of the Secrets Manager secret containing the master password"
  value       = module.rds.db_instance_master_user_secret_arn
}

##############################
# EC2
##############################

output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = module.ec2_instance.public_ip
}

output "ec2_private_ip" {
  description = "Private IP of the EC2 instance"
  value       = module.ec2_instance.private_ip
}

output "ec2_instance_id" {
  description = "EC2 instance ID"
  value       = module.ec2_instance.id
}

##############################
# Security groups
##############################

output "ec2_security_group_id" {
  description = "Security group ID attached to the EC2 instance"
  value       = module.ec2_security_group.id
}

output "rds_security_group_id" {
  description = "Security group ID attached to the RDS instance"
  value       = module.rds_security_group.id
}
