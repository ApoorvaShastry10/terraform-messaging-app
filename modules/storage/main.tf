resource "aws_s3_bucket" "media_storage" {
  bucket = "${var.environment}-app-media-storage-${random_id.bucket_id.hex}"

}

resource "aws_s3_bucket_website_configuration" "media_storage" {
  bucket = aws_s3_bucket.media_storage.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

resource "random_id" "bucket_id" {
  byte_length = 4
}

resource "aws_s3_bucket_lifecycle_configuration" "media_storage_lifecycle" {
  bucket = aws_s3_bucket.media_storage.bucket

  rule {
    id     = "expire-old-objects"
    status = "Enabled"

    filter {
      prefix = "logs/"
    }

    expiration {
      days = 30
    }
  }
}

resource "aws_s3_bucket_versioning" "media_storage" {
  bucket = aws_s3_bucket.media_storage.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "media_storage" {
  bucket = aws_s3_bucket.media_storage.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket                  = aws_s3_bucket.media_storage.id
  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_object" "index_html" {
  bucket = aws_s3_bucket.media_storage.bucket
  key    = "index.html" # Object key in the bucket
  source = "index.html" # Local path to the file
  content_type = "text/html"
}


resource "aws_s3_bucket_policy" "media_policy" {
  bucket = aws_s3_bucket.media_storage.id

   policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "s3:*",
        Effect    = "Allow",
        Resource  = [
          "arn:aws:s3:::${aws_s3_bucket.media_storage.id}",
          "arn:aws:s3:::${aws_s3_bucket.media_storage.id}/*"
        ],
        Principal = "*"
      }
    ]
  })
}
