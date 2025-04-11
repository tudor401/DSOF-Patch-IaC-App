resource "aws_s3_bucket" "insecure-bucket" {
  bucket = "insecure-bucket"
  versioning.enabled = true
  versioning.mfa_delete = true
}

# resource "aws_s3_bucket_public_access_block" "insecure-bucket" {
#   block_public_acls       = true
#   block_public_policy     = true
#   ignore_public_acls      = true
#   restrict_public_buckets = true
# }

resource "aws_ebs_volume" "example" {
  availability_zone = "us-east-1a"
  size              = 20
  tags = {
    Name = "insecure"
  }
}

resource "aws_s3_bucket_acl" "my_acl" {
  bucket = aws_s3_bucket.insecure-bucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "my_versioning" {
  bucket = aws_s3_bucket.insecure-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}