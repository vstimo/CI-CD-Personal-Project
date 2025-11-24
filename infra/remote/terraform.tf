# remote/terraform.tf
# https://medium.com/@hindolroy.2306/managing-terraform-remote-state-with-s3-dynamodb-a-practical-step-by-step-guide-6b37a673ba39
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}