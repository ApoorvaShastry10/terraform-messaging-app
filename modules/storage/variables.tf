variable "bucket_name" {
  description = "Name of the S3 bucket"
  type        = string
}

variable "noncurrent_version_retention_days" {
  description = "Number of days to retain noncurrent versions of objects"
  type        = number
  default     = 30
}

variable "object_retention_days" {
  description = "Number of days to retain objects in the bucket"
  type        = number
  default     = 365
}

variable "allowed_referer" {
  description = "Referer header to restrict S3 access"
  type        = string
  default     = "https://example.com"
}

variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
}

variable "static_page_path" {
  description = "Path to the static HTML file"
  type        = string
  default     = "index.html"
}