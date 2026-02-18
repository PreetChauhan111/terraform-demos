variable "region" {
  description = "AWS region"
  type = string
  default = "ap-south-1"
}
variable "vpc_cidr" {
  description = "cidr value for public and private vpcs"
  type = map(string)
  default = {
    "public_vpc" = "10.0.0.0/16"
    "private_vpc" = "10.1.0.0/16"
  }
}
variable "azs" {
  description = "availability zones"
  type = list(string)
  default = [ "ap-south-1a", "ap-south-1b", "ap-south-1c" ]
}
variable "public_subnets" {
  description = "public subnets"
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
}
variable "private_subnets" {
  description = "private subnets"
  type = list(string)
  default = [ "10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24" ]
}