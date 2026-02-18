variable "region" {
  type = string
  default = "ap-south-1"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "azs" {
  type = list(string)
  default = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]
}

variable "public_subnets" {
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
}

variable "private_subnets" {
  type = list(string)
  default = [ "10.0.16.0/24", "10.0.17.0/24", "10.0.18.0/24" ]
}

variable "instance_type" {
  type = string
  default = "t3.micro"
}
