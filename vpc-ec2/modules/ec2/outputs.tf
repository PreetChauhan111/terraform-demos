output "ec2_web_access" {
  description = "Ec2 url"
  value = aws_instance.demo-ec2.public_ip
}