data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default_vpc_public_subnet" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }
}

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
