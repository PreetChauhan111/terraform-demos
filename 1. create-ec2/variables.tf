# variable "name" {
#   type    = set(string)
#   default = ["ec2", "instance", "demo", "ec2-instance"]
# }

# variable "allowed_region" {
#   type    = set(string)
#   default = ["ap-south-1", "us-east-1", "us-east-2", "eu-west-1"]
# }

# variable "instance_type" {
#   type = string

#   validation {
#     condition     = length(var.instance_type) > 2 && length(var.instance_type) < 20
#     error_message = "The instance type must be between 2 and 20."
#   }

#   validation {
#     condition     = can(regex("^t[2,3]\\.", var.instance_type))
#     error_message = "The instance type must start with 't2.' or 't3."
#   }
# }