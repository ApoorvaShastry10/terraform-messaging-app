variable "vpc_cidr" {}
variable "public_subnet_cidrs" {
  type = list(string)
}

variable "availability_zones" {
  description = "List of availability zones in the region"
  type        = list(string)
  default     = ["us-west-1a", "us-west-1b"]  # Example AZs
}