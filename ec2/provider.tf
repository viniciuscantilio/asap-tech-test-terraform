terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.49.0"
    }
  }
  required_version = ">= 1.8.3"
}

provider "aws" {
  region = "us-east-1"

}  