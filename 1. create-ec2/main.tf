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