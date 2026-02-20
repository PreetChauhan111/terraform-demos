##########################################
# EC2 Instance Using Count               #
##########################################

module "ec2-instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "6.2.0"
  count   = length(var.instance_types)

  name          = "ec2-${count.index}"
  ami           = "ami-0317b0f0a0144b137" # Amazon Linux 2 AMI (HVM), SSD Volume Type
  instance_type = values(var.instance_types)[count.index]
  subnet_id = data.aws_subnet.default.id
}