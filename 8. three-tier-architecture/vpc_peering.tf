##############
# VPC Peering
##############

resource "aws_vpc_peering_connection" "fs-peering" {
  vpc_id      = module.vpc["public_vpc"].vpc_id
  peer_vpc_id = module.vpc["private_vpc"].vpc_id
  auto_accept = true
  requester {
    allow_remote_vpc_dns_resolution = true
  }
  accepter {
    allow_remote_vpc_dns_resolution = true
  }
}
resource "aws_route" "public_vpc_pub_1" {
  route_table_id            = module.vpc["public_vpc"].public_route_table_ids[0]
  destination_cidr_block    = module.vpc["private_vpc"].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.fs-peering.id
}
resource "aws_route" "public_vpc_pub_2" {
  route_table_id            = module.vpc["public_vpc"].public_route_table_ids[1]
  destination_cidr_block    = module.vpc["private_vpc"].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.fs-peering.id
}
resource "aws_route" "private_vpc_priv_1" {
  route_table_id            = module.vpc["private_vpc"].private_route_table_ids[0]
  destination_cidr_block    = module.vpc["public_vpc"].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.fs-peering.id
}
resource "aws_route" "private_vpc_priv_2" {
  route_table_id            = module.vpc["private_vpc"].private_route_table_ids[1]
  destination_cidr_block    = module.vpc["public_vpc"].vpc_cidr_block
  vpc_peering_connection_id = aws_vpc_peering_connection.fs-peering.id
}