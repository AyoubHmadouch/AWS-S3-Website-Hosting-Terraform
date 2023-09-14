output "bucket_id" {
  value       = aws_s3_bucket.simple-website-bucket.id
  description = "The bucket id"
}

output "website_URL" {
  value       = "http://${aws_s3_bucket_website_configuration.static-web-hosting.website_endpoint}"
  description = "The website URL"
}
