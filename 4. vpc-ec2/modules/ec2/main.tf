provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "demo-ec2" {
  ami           = data.aws_ami.amazon_linux.id # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = "t3.micro"
  tags = {
    Name = "Demo-EC2"
  }
  vpc_security_group_ids = [var.security_group_id]
  subnet_id = var.subnet_id

  user_data = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo amazon-linux-extras install nginx1 -y
              sudo systemctl start nginx
              EOF
  }