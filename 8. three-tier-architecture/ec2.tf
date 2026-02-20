############################
# Backend Instance         #
############################

module "backend" {
  source                = "terraform-aws-modules/ec2-instance/aws"
  version               = "6.2.0"
  name                  = local.backend_instance_name
  ami                   = var.ami_id_ubuntu
  instance_type         = var.instance_type
  subnet_id             = module.vpc["public_vpc"].public_subnets[0]
  create_security_group = true
  security_group_ingress_rules = {
    backend = {
      from_port   = 8080
      to_port     = 8080
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
    ssh = {
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  user_data = templatefile(local.backend_script, {
    backend_tar_b64 = local.backend_tar_b64
    db_host         = module.rds.db_instance_address
    db_username     = var.db_username
    db_password     = var.db_password
    db_name         = var.db_name
  })
  depends_on = [module.rds]
}

############################
# Frontend Instance        #
############################

module "frontend" {
  source                = "terraform-aws-modules/ec2-instance/aws"
  version               = "6.2.0"
  name                  = local.frontend_instance_name
  ami                   = var.ami_id
  instance_type         = var.instance_type
  subnet_id             = module.vpc["public_vpc"].public_subnets[0]
  create_security_group = true
  security_group_ingress_rules = {
    http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
    ssh = {
      from_port   = 22
      to_port     = 22
      ip_protocol = "tcp"
      cidr_ipv4   = "0.0.0.0/0"
    }
  }
  user_data = templatefile(local.frontend_script, {
    frontend_tar_b64 = local.frontend_tar_b64
    backend_ip       = module.backend.public_ip
  })
  depends_on = [module.backend]
}