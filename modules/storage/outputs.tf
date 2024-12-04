output "s3_bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.media_storage.bucket
}

output "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.media_storage.arn
}

output "static_website_url" {
  value = aws_s3_bucket_website_configuration.media_storage.website_endpoint
  description = "URL of the S3 static website"
}