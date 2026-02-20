provider "aws" {
  region = "ap-south-1"
}

########## Using Count ############

# resource "aws_instance" "demo-ec2" {
#   count         = length(var.name)
#   ami           = "ami-0317b0f0a0144b137" # Amazon Linux 2 AMI (HVM), SSD Volume Type
#   instance_type = "t3.micro"
#   tags = {
#     Name : "${local.ec2_name}-${count.index + 1}"
#   }
# }

########## Using For Each ############

# resource "aws_instance" "create_ec2" {
#   ami           = "ami-0317b0f0a0144b137" # Amazon Linux 2 AMI (HVM), SSD Volume Type
#   instance_type = "t3.micro"
#   for_each = var.name
#   tags = {
#     Name = each.key
#   }
# }

########## Set Property ############

# resource "aws_instance" "demo" {
#   ami = "ami-0317b0f0a0144b137" # Amazon Linux 2 AMI (HVM), SSD Volume Type
#   count = length(var.allowed_region)
#   instance_type = "t3.micro"
#   region = tolist(var.allowed_region)[count.index]
# }

########## Using Splat Expression ############

# resource "aws_instance" "demo" {
#   count = length(var.name)
#   ami = "ami-0317b0f0a0144b137" # Amazon Linux 2 AMI (HVM), SSD Volume Type
#   instance_type = "t3.micro"
# }

# locals {
#   instance_ids = aws_instance.demo[*].id
# }

# output "instance_ids" {
#   value = local.instance_ids
# }

data "aws_subnet" "default_vpc_public_subnet" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }
}

module "ec2-instance" {
  source                = "terraform-aws-modules/ec2-instance/aws"
  version               = "6.2.0"
  instance_type         = "t3.micro"
  subnet_id             = data.aws_subnet.default_vpc_public_subnet.id
  create_security_group = true
  security_group_name   = "fs-ec2"
  security_group_ingress_rules = {
    http = {
      description = "Allow HTTP"
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
    ssh = {
      description = "Allow SSH"
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  security_group_egress_rules = {
    all-all = {
      description = "Allow all"
      from_port   = 0
      to_port     = 0
      ip_protocol = "-1"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  user_data = templatefile("${path.module}/userData.sh", {
    frontend_tar_b64 = local.frontend_tar_b64
    nginx_tar_b64    = local.nginx_tar_b64
  })
}