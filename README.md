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

aws dynamodb create-table --table-name terraform-locks --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5

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

# Understand the entire flow after we run "terraform apply"

# Repository Structure

provider.tf — Defines the Terraform backend and AWS provider.

variables.tf — Declares input variables.

locals.tf — Defines reusable computed values.

main.tf — Contains the core resources, loops, and module usage.

outputs.tf — Specifies outputs to be displayed after apply.

modules/s3_bucket/ — A custom module for creating S3 buckets.

The Full terraform apply Flow

1. terraform init

Downloads required provider plugins (like AWS).

Sets up the remote backend (S3 + DynamoDB) for state storage and locking as defined in provider.tf.

Ensures the module at modules/s3_bucket is locally available.

2. Input Gathering & Validation

Terraform reads variables.tf.

It prompts for any non-default values (or reads them from terraform.tfvars, env vars, etc.).

It applies validations—e.g., checking types match (strings vs numbers, etc.).

3. Local Values Computed

Terraform resolves computed values in locals.tf. These are internal constants used across your config (like tags or project names).

4. State Initialization & Locking

Through the backend configuration in provider.tf, Terraform:

Retrieves the existing state from S3 (if any).

Acquires a lock in DynamoDB to avoid concurrent modifications—ensuring no race conditions.

5. Execution Plan

Terraform inspects main.tf and, using the current state plus module logic, figures out:

What needs to be created, changed, or destroyed.

How dynamic loops (for_each) and modules are expanded.

Produces a plan, showing all upcoming operations.

6. Apply

After approval (auto or manual), Terraform:

Makes API calls to create/update/delete resources (EC2, S3 buckets, Security Groups, etc.).

Automatically expands dynamic blocks (like loops or dynamic ingress rules) and modules (like your S3 bucket).

Ensures dependencies are respected (e.g., buckets before attaching policies).

7. Finalize State & Unlock

Once done, Terraform:

Writes the updated state back to S3.

Removes the lock in DynamoDB, allowing other users or pipelines to proceed.

8. Outputs

Terraform evaluates and displays values from outputs.tf, such as EC2 public IP, S3 bucket names, etc.

9. Cleanup (if requested)

If you later run terraform destroy, Terraform uses the state to safely dismantle resources in reverse order, then updates the state accordingly.
