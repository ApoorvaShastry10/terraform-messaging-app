variable "vpc_id" {
  description = "ID of the VPC where the compute instances will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs where the instances will be deployed"
  type        = list(string)
}

# variable "security_group_id" {
#   description = "Security group ID for the instances"
#   type        = string
# }

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "desired_capacity" {
  description = "Desired number of instances"
  type        = number
}

variable "max_capacity" {
  description = "Maximum number of instances"
  type        = number
}

variable "min_capacity" {
  description = "Minimum number of instances"
  type        = number
}

variable "security_group_ids" {
  type = list(string)
}
