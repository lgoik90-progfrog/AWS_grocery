data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "avatars" {
  bucket = "grocerymate-avatars-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "grocerymate-avatars"
    Environment = "dev"
    Project     = "grocerymate"
  }
}

resource "aws_s3_bucket_public_access_block" "avatars" {
  bucket = aws_s3_bucket.avatars.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_versioning" "avatars" {
  bucket = aws_s3_bucket.avatars.id

  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "avatars" {
  bucket = aws_s3_bucket.avatars.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

output "s3_avatar_bucket_name" {
  description = "Name of the private S3 bucket for GroceryMate avatars"
  value       = aws_s3_bucket.avatars.bucket
}