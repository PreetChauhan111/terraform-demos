provider "aws" {
  region = "ap-south-1"
}

resource "aws_s3_bucket" "demo" {
  bucket = local.final_bucket_name
  tags = {
    Name = "My bucket"
  }
}