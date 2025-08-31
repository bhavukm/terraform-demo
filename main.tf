data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
}

# Resource: EC2 Instance
resource "aws_instance" "demo_server" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.env == "prod" ? "t2.medium" : var.instance_type
  tags = merge(local.common_tags, {
    Name = "${local.project_name}-${var.env}-server"
  })
}

# Loop with for_each: S3 Buckets
resource "aws_s3_bucket" "demo_buckets" {
  for_each = toset(var.bucket_names)
  bucket   = "${local.project_name}-${each.key}-${var.env}"
  tags     = local.common_tags
}

# Using a Module: Custom S3 bucket module
module "extra_bucket" {
  source = "./modules/s3_bucket"
  bucket_name = "${local.project_name}-extra-${var.env}"
  tags        = local.common_tags
}
