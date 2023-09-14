locals {
  bucket_name = "${var.bucket_name}-${var.aws_accoundId}"
}

# S3 bucket
resource "aws_s3_bucket" "simple-website-bucket" {
  bucket = local.bucket_name

  tags = {
    Name = "simple-website"
  }
}

# S3 Bucket Ownership Controls 
resource "aws_s3_bucket_ownership_controls" "ownership-controls" {
  bucket = aws_s3_bucket.simple-website-bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# public access block 
resource "aws_s3_bucket_public_access_block" "public-access-block" {
  bucket = aws_s3_bucket.simple-website-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

# static web hosting
resource "aws_s3_bucket_website_configuration" "static-web-hosting" {
  bucket = aws_s3_bucket.simple-website-bucket.id

  index_document {
    suffix = "index.html"
  }

  error_document {
    key = "error.html"
  }
}

# index.html object
resource "aws_s3_object" "index-html" {
  bucket       = aws_s3_bucket.simple-website-bucket.id
  key          = "index.html"
  source       = "sample-website/index.html"
  content_type = "text/html"
}

# error.html object
resource "aws_s3_object" "error-html" {
  bucket       = aws_s3_bucket.simple-website-bucket.id
  key          = "error.html"
  source       = "sample-website/error.html"
  content_type = "text/html"
}

# bucket policy for a public access
resource "aws_s3_bucket_policy" "public-access-policy" {
  bucket = aws_s3_bucket.simple-website-bucket.id
  policy = <<EOF
    {
        "Id": "Policy1694721466399",
        "Version": "2012-10-17",
        "Statement": [
        {
            "Sid": "Stmt1694721464800",
            "Action": [
                "s3:GetObject"
            ],
            "Effect": "Allow",
            "Resource": "arn:aws:s3:::${aws_s3_bucket.simple-website-bucket.id}/*",
            "Principal": "*"
        }]
    }
  EOF
}