data "aws_subnet" "default" {
  filter {
    name   = "tag:Name"
    values = ["default"]
  }
}