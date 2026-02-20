variable "region" {
  type    = string
  default = "ap-south-1"
}
variable "map" {
  type = map(string)
  default = {
    "a" = "b"
    "c" = "d"
  }
}
variable "list" {
  type    = list(string)
  default = ["a", "c"]
}
variable "set" {
  type    = set(string)
  default = ["a", "b", "c"]
}
variable "tuple" {
  type    = tuple([string, string, string])
  default = ["a", "b", "c"]
}
variable "instance_types" {
  type = map(string)
  default = {
    dev  = "t2.micro"
    test = "t2.small"
    prod = "t3.large"
  }
}