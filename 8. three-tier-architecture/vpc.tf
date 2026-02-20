module "vpc" {
  for_each                                                  = var.vpcs
  source                                                    = "terraform-aws-modules/vpc/aws"
  version                                                   = "6.6.0"
  name                                                      = each.value.name
  cidr                                                      = each.value.cidr
  azs                                                       = var.azs
  public_subnets                                            = each.value.vpc_type == "public" ? each.value.public_subnets : []
  private_subnets                                           = each.value.private_subnets
  create_igw                                                = each.value.vpc_type == "public" ? true : false
  create_multiple_public_route_tables                       = each.value.vpc_type == "public" ? true : false
  create_multiple_intra_route_tables                        = true
  enable_dns_support                                        = true
  enable_dns_hostnames                                      = true
  manage_default_security_group                             = false
  map_public_ip_on_launch                                   = each.value.vpc_type == "public" ? true : false
  public_subnet_enable_resource_name_dns_a_record_on_launch = each.value.vpc_type == "public" ? true : false
  default_network_acl_ingress = each.value.vpc_type == "private" ? [
    {
      rule_no    = 100
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = local.public_vpc_cidr
    }
    ] : [
    {
      rule_no    = 100
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }
  ]
  default_network_acl_egress = each.value.vpc_type == "private" ? [
    {
      rule_no    = 100
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = local.public_vpc_cidr
    }
    ] : [
    {
      rule_no    = 100
      action     = "allow"
      from_port  = 0
      to_port    = 0
      protocol   = "-1"
      cidr_block = "0.0.0.0/0"
    }
  ]
} 