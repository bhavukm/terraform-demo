output "ec2_public_ip" {
  description = "Public IP of the EC2 instance"
  value       = aws_instance.demo_server.public_ip
}

output "s3_bucket_names" {
  description = "Names of created S3 buckets"
  value       = [for b in aws_s3_bucket.demo_buckets : b.bucket]
}

output "extra_bucket_name" {
  description = "Name of the bucket created via module"
  value       = module.extra_bucket.bucket_id
}
