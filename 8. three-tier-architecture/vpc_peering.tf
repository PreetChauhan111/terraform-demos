##############
# VPC Peering
##############

module "vpc-peering" {
  source  = "cloudposse/vpc-peering/aws"
  version = "1.0.1"
  name = "${local.public_vpc_name}-to-${local.private_vpc_name}"
  requestor_vpc_id = module.public_vpc.vpc_id
  acceptor_vpc_id = module.private_vpc.vpc_id
  auto_accept = true
}

# Adding the route from private to public
resource "aws_route" "private-to-public" {
  route_table_id            = module.public_vpc.public_route_table_ids[0]
  destination_cidr_block    = module.private_vpc.vpc_cidr_block
  vpc_peering_connection_id = module.vpc-peering.id
}

# Adding the route from public to private
resource "aws_route" "public-to-private" {
  route_table_id            = module.private_vpc.intra_route_table_ids[0]
  destination_cidr_block    = module.public_vpc.vpc_cidr_block
  vpc_peering_connection_id = module.vpc-peering.id
}