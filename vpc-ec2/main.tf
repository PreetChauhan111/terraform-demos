provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"
  vpc_cidr = "10.0.0.0/16"
  private_subnet_cidr = "10.0.1.0/24"
  public_subnet_cidr = "10.0.2.0/24"
}

module "ec2" {
  source = "./modules/ec2"
  subnet_id         = module.vpc.public_subnet_id
  security_group_id = module.vpc.security_group_id
}