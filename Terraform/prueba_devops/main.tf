provider "aws" {
    region= "us-east-1"
    access_key = "AKIAVFIWI7D462ACDUWP"
    secret_key = "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"
}
module "vpc" {
  source = "./modules/vpc"
  cidr = var.cidr
}

module "ec2" {
  source = "./modules/ec2"
  
}