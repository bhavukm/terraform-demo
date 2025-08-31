# terraform-demo

Hands-On Demo:-

<img width="447" height="270" alt="image" src="https://github.com/user-attachments/assets/59b7a34f-22f4-44b0-8db9-ecd4e2a63ccd" />

How to Run (on Ubuntu)?

1. Install Terraform

https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli

2. Configure AWS CLI
   
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html

aws configure  #Setup AWS IAM role or user access keys
  
#Create an s3 bucket

aws s3api create-bucket --bucket tf-techapricate --region us-east-1

#Create a DynamoDB table

aws dynamodb create-table \

  --table-name terraform-locks \
  
  --attribute-definitions AttributeName=LockID,AttributeType=S \
  
  --key-schema AttributeName=LockID,KeyType=HASH \
  
  --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

# Initialize Terraform

terraform init

# Validate & Plan

terraform validate

terraform plan

# Apply Changes

terraform apply -auto-approve

# Check Outputs

terraform output

# Destroy Resources

terraform destroy -auto-approve
