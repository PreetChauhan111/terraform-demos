output "public_subnet_id" {
  value = aws_subnet.demo-public-subnet.id
}

output "security_group_id" {
  value = aws_security_group.demo-sg.id
}