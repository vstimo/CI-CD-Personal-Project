terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # Configuration to pickup the terraform state from S3 using DynamoDB lock
  backend "s3" {
    bucket = "timo-remote-terraform-state-bucket"
    key = "terraform.tfstate"
    region = "us-west-1"
    dynamodb_table = "timo-remote-terraform-state-table"
  }
}