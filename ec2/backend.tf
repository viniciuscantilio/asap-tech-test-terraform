terraform {
  backend "s3" {
    region  = "us-east-1"
    bucket  = "asap-tech-vinicius-terraform"
    encrypt = "true"
    key     = "asap-tech-vinicius/us-east-1/teste-k8s/ec2/state.tfstate"
  }
}