##########################################
# VPC to host frontend and backend servers
##########################################

module "public_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"
  name = local.public_vpc_name
  cidr = var.vpc_cidr[0]
  azs             = var.azs
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets
  create_igw = true
  create_multiple_intra_route_tables = true
  create_multiple_public_route_tables = true
  enable_dns_support   = true
  enable_dns_hostnames = true
  intra_dedicated_network_acl = true
  intra_acl_tags = {
    "name" = "${local.public_vpc_name}-intra-acl"
  }
  public_dedicated_network_acl = true
  public_acl_tags = {
    "name" = "${local.public_vpc_name}-public-acl"
  }
}

##############################
# VPC to host database server
##############################

module "private_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.6.0"
  name = local.private_vpc_name
  cidr = var.vpc_cidr[1]
  azs             = var.azs
  private_subnets = var.private_subnets
  create_multiple_intra_route_tables = true
  enable_dns_support   = true
  enable_dns_hostnames = true
  intra_dedicated_network_acl = true
  intra_acl_tags = {
    "name" = "${local.private_vpc_name}-intra-acl"
  }
  intra_inbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 3306
      to_port     = 3306
      protocol    = "tcp"
      cidr_block  = var.vpc_cidr[0]
    }
  ]
  intra_outbound_acl_rules = [
    {
      rule_number = 100
      rule_action = "allow"
      from_port   = 1024
      to_port     = 65535
      protocol    = "tcp"
      cidr_block  = var.vpc_cidr[0]
    }
  ]
}