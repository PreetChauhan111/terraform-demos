variable "vpc_cidr" {
  description = "This is cidr for your vpc"
  type = string
}

variable "private_subnet_cidr" {
  description = "This is cidr for your private subnet"
  type = string
}

variable "public_subnet_cidr" {
  description = "This is cidr for your public subnet"
  type = string
}