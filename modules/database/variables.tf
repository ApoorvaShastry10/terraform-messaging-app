variable "vpc_id" {
  description = "The VPC ID in which RDS and EC2 resources will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the RDS subnet group"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of EC2 security group IDs to be associated with the RDS instance"
  type        = list(string)
}