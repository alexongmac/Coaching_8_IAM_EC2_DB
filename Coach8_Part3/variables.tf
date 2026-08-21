
variable "name" {
  description = "the name of the resource"
  type        = string
  default     = "alex-tf"
}

variable "instance_type" {
  description = "the type of instance to create"
  type        = string
  default     = "t3.micro"
}

variable "environment" {
  description = "the environment to deploy to"
  type        = string
  default     = "dev"
}

variable "key_name" {
  description = "the name of the key pair to use for the instance"
  type        = string
  default     = "alex-key-pair"
}

#############################################
## Variables for RDS
#############################################

variable "db_engine" {
  description = "the database engine to use"
  type        = string
  default     = "mysql"
}

variable "db_engine_version" {
  description = "the database engine version to use"
  type        = string
  default     = "8.0"
}

variable "db_instance_class" {
  description = "the database instance class to use"
  type        = string
  default     = "db.t4g.micro"
}

variable "db_allocated_storage" {
  description = "the allocated storage for the database"
  type        = number
  default     = 20
}

variable "db_storage_type" {
  description = "the storage type for the database"
  type        = string
  default     = "gp2"
}

variable "db_username" {
  description = "the username for the database"
  type        = string
  default     = "admin"
}

variable "db_port" {
  description = "MySQL port no."
  type = string
  default = "3306"
}

