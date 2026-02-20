module "security-group" {
  source      = "terraform-aws-modules/security-group/aws"
  version     = "5.3.1"
  name        = "rds_sg"
  description = "Security group for RDS"
  vpc_id      = module.vpc["private_vpc"].vpc_id
  ingress_with_cidr_blocks = [
    {
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_blocks = "10.0.0.0/16"
    }
  ]
  egress_with_cidr_blocks = [
    {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = "0.0.0.0/0"
    }
  ]
  depends_on = [module.vpc]
}