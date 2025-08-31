terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = "tf-techapricate"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    use_lockfile   = true
    encrypt        = true
  }
}

provider "aws" {
  region = var.aws_region
}
