provider "aws" {
  region = var.region
}

###########################################
# Create VPC
###########################################

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"

  name = local.vpc_name

  # Create a new VPC

  cidr            = var.vpc_cidr
  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = [var.public_subnets[0]]

  public_subnet_enable_resource_name_dns_a_record_on_launch = true
  map_public_ip_on_launch = true

  # DNS Properties

  enable_dns_support   = true
  enable_dns_hostnames = true

  # Create Internet Gateway

  create_igw = true

  igw_tags = {
    "name" = local.igw
  }

  # Create private nacl

  manage_default_network_acl = false

  private_dedicated_network_acl = true

  private_inbound_acl_rules = [

    {
      cidr_block  = var.default_vpc_cidr
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
    }

  ]

  private_outbound_acl_rules = [
    {
      cidr_block  = var.default_vpc_cidr
      rule_number = 100
      rule_action = "allow"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
    }
  ]

  # Create public nacl

  public_dedicated_network_acl = true

  # Create route table

  create_multiple_public_route_tables = true

  create_multiple_intra_route_tables = true

  # Create Security Groups



}

# Create peering connection

data "aws_vpc" "default_vpc" {
  default = true
}

resource "aws_vpc_peering_connection" "fs-peering" {
  vpc_id      = module.vpc.vpc_id
  peer_vpc_id = data.aws_vpc.default_vpc.id

  auto_accept = true
}

# Adding the route

resource "aws_route" "fs-peering-route" {
  route_table_id            = module.vpc.public_route_table_ids[0]
  destination_cidr_block    = data.aws_vpc.default_vpc.cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.fs-peering.id
}

resource "aws_route" "default-peering-route" {
  route_table_id            = data.aws_vpc.default_vpc.main_route_table_id
  destination_cidr_block    = module.vpc.vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.fs-peering.id
}

###########################################
# Create EC2 Instance
###########################################

data "aws_ami" "amazon_linux" {
  most_recent = true
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["amazon"]
}

data "aws_subnet" "default_vpc_public_subnet" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }
}

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.2.0"

  name = local.instance_name

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = module.vpc.public_subnets[0]

  create_security_group = true

  security_group_name = "fs-ec2"

  security_group_ingress_rules = {
    http = {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }

    https = {
      description = "Allow HTTPS"
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }

    ssh = {
      description = "Allow SSH"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install nginx1 -y
              sudo systemctl start nginx
              EOF
}

module "ec2-default" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.2.0"

  name = local.instance_name

  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = data.aws_subnet.default_vpc_public_subnet.id

  create_security_group = true

  security_group_name = "default-ec2"

  security_group_ingress_rules = {
    http = {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }

    https = {
      description = "Allow HTTPS"
      from_port   = 443
      to_port     = 443
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }

    ssh = {
      description = "Allow SSH"
      from_port   = 22
      to_port     = 22
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
}