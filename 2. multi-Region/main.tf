provider "aws" {
  alias  = "ap-south-1"
  region = "ap-south-1"
}

provider "aws" {
  alias  = "us-east-1"
  region = "us-east-1"
}

resource "aws_instance" "demo-ec2-ap-south-1" {
  provider      = aws.ap-south-1
  ami           = "ami-0317b0f0a0144b137" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t3.micro"
}

resource "aws_instance" "demo-ec2-us-east-1" {
  provider      = aws.us-east-1
  ami           = "ami-0c1fe732b5494dc14" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t3.micro"
}