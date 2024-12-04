variable "name" {
  description = "Name of the security group"
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where the security group will be created"
  type        = string
}

variable "tags" {
  description = "Tags for the security group"
  type        = map(string)
  default     = {}
}
