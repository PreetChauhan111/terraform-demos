provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "demo-ec2" {  
  ami           = "ami-0317b0f0a0144b137" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t3.micro"  
}