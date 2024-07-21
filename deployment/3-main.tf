terraform {
  backend "s3" {
    bucket = "chaty-app-terraform-state" # Your unique AWS S3 bucket
    # create a sub-folder called develop
    key = "develop/chatapp.tfstate"
    #region  = var.aws_region # Your AWS region
    region  = "us-east-1"
    encrypt = true
  }
}

locals {
  prefix = "${var.prefix}-${terraform.workspace}"

  common_tags = {
    Environment = terraform.workspace
    Project     = var.project
    ManagedBy   = "Terraform"
    Owner       = "Noufal KV" # Your fullname
  }
}
