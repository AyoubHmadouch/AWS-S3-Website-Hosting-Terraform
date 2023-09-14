variable "aws_accoundId" {
  type        = string
  default     = "655734544982"
  description = "The AWS account id"
}

variable "region" {
  type        = string
  default     = "us-east-1"
  description = "The AWS Region"
}

variable "bucket_name" {
  type        = string
  default     = "simple-website-bucket"
  description = "The bucket name"
}
