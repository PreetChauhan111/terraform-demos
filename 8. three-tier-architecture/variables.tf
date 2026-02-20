variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}
variable "vpcs" {
  type = map(object({
    name            = string
    cidr            = string
    vpc_type        = string # public | private
    public_subnets  = list(string)
    private_subnets = list(string)
  }))
}
variable "ami_id" {
  type = string
}
variable "ami_id_ubuntu" {
  type = string
}
variable "vpc_cidr" {
  description = "cidr value for public and private vpcs"
  type        = map(string)
  default = {
    "public_vpc"  = "10.0.0.0/16"
    "private_vpc" = "10.1.0.0/16"
  }
}
variable "azs" {
  description = "availability zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
}
variable "instance_type" {
  description = "instance type"
  type        = string
  default     = "t3.micro"
}
variable "db_username" {
  description = "database username"
  type        = string
  default     = "admin"
}
variable "db_password" {
  description = "database password"
  type        = string
  default     = "admin12345"
}
variable "db_name" {
  description = "database name"
  type        = string
  default     = "appdb"
}
variable "mysql_port" {
  description = "mysql port"
  type        = number
  default     = 3306
}