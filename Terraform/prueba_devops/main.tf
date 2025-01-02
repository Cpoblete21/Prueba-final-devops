# Proveedor de AWS
provider "aws" {
  region  = var.aws_region
}


# Módulo VPC
module "vpc" {
  source         = "./modules/vpc"
  vpc_cidr_block = var.vpc_cidr_block
}

# Módulo Subnet
module "subnet" {
  source                   = "./modules/subnet"
  vpc_id                   = module.vpc.vpc_id
  subnet_cidr_block        = var.subnet_cidr_block
  subnet_availability_zone = var.subnet_availability_zone
}


#Modulo IGW
module "igw" {
  source           = "./modules/igw"
  vpc_id           = module.vpc.vpc_id
  internet_gw_name = local.internet_gw_name
}

#Modulo Route
module "route" {
  source         = "./modules/route"
  vpc_id         = module.vpc.vpc_id
  internet_gw_id = module.igw.aws_internet_gateway_id
  subnet_id      = module.subnet.subnet_id
}

#Module S3
module "S3" {
  source         = "./modules/s3"
  s3_bucket_name = var.s3_bucket_name
}

#Module SG

module "sg" {
  source = "./modules/sg"
  vpc_id = module.vpc.vpc_id
}

# Módulo EC2
module "ec2" {
  source        = "./modules/ec2"
  ami_id        = "ami-0ca9fb66e076a6e32"
  instance_type = var.instance_type
  subnet_id     = module.subnet.subnet_id
  instance_name = local.instance_name
  key_name      = var.key_name
  sg_id         = module.sg.aws_security_group_id
}

