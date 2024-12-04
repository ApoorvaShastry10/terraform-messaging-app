variable "subnet_ids" {
  type = list(string)
}
variable "security_group_ids" {
  type = list(string)
}


variable "instance_type" {
  description = "The instance type for the Redis cluster nodes"
  type        = string
}

variable "environment" {
  description = "The environment (e.g., dev, staging, production)"
  type        = string
}


variable "node_count" {
  description = "Number of Redis nodes in the cluster"
  type        = number
  default     = 1
}

variable "cache_subnet_group_name" {
  description = "The name of the subnet group for ElastiCache"
  type        = string
}
