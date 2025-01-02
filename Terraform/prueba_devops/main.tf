provider "aws" {
    region= "us-east-1"

}
module "vpc" {
  source = "./modules/vpc"
  cidr = var.cidr
}

module "ec2" {
  source = "./modules/ec2"
  
}
