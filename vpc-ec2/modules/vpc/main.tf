provider "aws" {
  region = "ap-south-1"
}

# Create VPC

resource "aws_vpc" "demo-vpc" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "demo-vpc"
  }  
}

# Create Internet Gateway

resource "aws_internet_gateway" "demo-igw" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "demo-igw"
  }
}

# Subnets

resource "aws_subnet" "demo-private-subnet" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = var.private_subnet_cidr
  availability_zone = "ap-south-1a"
  tags = {
    Name = "demo-private-subnet"
  }  
}

resource "aws_subnet" "demo-public-subnet" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = var.public_subnet_cidr
  availability_zone = "ap-south-1a"
  enable_resource_name_dns_a_record_on_launch = true
  map_public_ip_on_launch = true
  tags = {
    Name = "demo-public-subnet"
  }  
}

# Route Tables and Associations

resource "aws_route_table" "demo-public-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "demo-public-rt"
  }

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.demo-igw.id
  }
}

resource "aws_route_table" "demo-private-rt" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "demo-private-rt"
  }

}

resource "aws_route_table_association" "demo-public-rt-association" {
  subnet_id = aws_subnet.demo-public-subnet.id
  route_table_id = aws_route_table.demo-public-rt.id
}

resource "aws_route_table_association" "demo-private-rt-association" {
  subnet_id = aws_subnet.demo-private-subnet.id
  route_table_id = aws_route_table.demo-private-rt.id
}

# Network ACLs and Associations

resource "aws_network_acl" "demo-nacl" {
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "demo-nacl"
  }

  ingress {
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 65535
  }

  egress {
    protocol = "tcp"
    rule_no = 100
    action = "allow"
    cidr_block = "0.0.0.0/0"
    from_port = 0
    to_port = 65535
  }
 
}

resource "aws_network_acl_association" "demo-nacl-association" {
  subnet_id = aws_subnet.demo-public-subnet.id
  network_acl_id = aws_network_acl.demo-nacl.id
}

resource "aws_network_acl_association" "demo-nacl-association-2" {
  subnet_id = aws_subnet.demo-private-subnet.id
  network_acl_id = aws_network_acl.demo-nacl.id
}

# Security Group

resource "aws_security_group" "demo-sg" {
  name = "demo-sg"
  description = "Security group for demo"
  vpc_id = aws_vpc.demo-vpc.id
  tags = {
    Name = "demo-sg"
  }

  ingress {
    protocol = "tcp"
    from_port = 22
    to_port = 22
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol = "tcp"
    from_port = 80
    to_port = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol = "tcp"
    from_port = 0
    to_port = 65535
    cidr_blocks = ["0.0.0.0/0"]
  }
}