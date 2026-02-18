region           = "ap-south-1"
default_vpc_cidr = "172.31.0.0/16"
vpc_cidr         = "10.0.0.0/16"
azs              = ["ap-south-1a", "ap-south-1b"]
public_subnets   = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnets  = ["10.0.16.0/24", "10.0.32.0/24"]
instance_type    = "t3.micro"