terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0, != 5.71.0"
    }
  }
}

provider "aws" {
  region     = "eu-central-1"
  shared_credentials_files = ["/mnt/c/Users/nl185095/.aws/credentials"]
}