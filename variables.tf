variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "bucket_names" {
  description = "List of S3 buckets to create"
  type        = list(string)
  default     = ["logs", "images", "backups"]
}

variable "env" {
  description = "Environment (dev/staging/prod)"
  type        = string
  default     = "dev"
}
