output "ec2_url" {
  value = "http://${module.ec2.ec2_web_access}"
}