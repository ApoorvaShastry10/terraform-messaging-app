variable "region" {
  description = "AWS region"
  default     = "us-west-1"
}

variable "instance_type" {
  description = "Instance type for compute resources"
  type        = string
  default     = "t2.micro" # Adjust based on your requirements
}

# variable "key_name" {
#   description = "Key pair name for SSH access"
#   type        = string
# }

variable "desired_capacity" {
  description = "Desired number of compute instances"
  type        = number
  default     = 1
}

variable "max_capacity" {
  description = "Maximum number of compute instances"
  type        = number
  default     = 5
}

variable "min_capacity" {
  description = "Minimum number of compute instances"
  type        = number
  default     = 1
}

variable "environment" {
  description = "Environment tag (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

# variable "subnet_ids" {
#   description = "List of subnet IDs for the ElastiCache Subnet Group"
#   type        = list(string)
# }
