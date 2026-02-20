locals {
  public_vpc_name        = var.vpcs.public_vpc.name
  private_vpc_name       = var.vpcs.private_vpc.name
  instance_name          = "${local.public_vpc_name}-instance"
  frontend_instance_name = "${local.public_vpc_name}-frontend"
  backend_instance_name  = "${local.public_vpc_name}-backend"
  frontend_tar_b64       = filebase64("${path.module}/frontend.tar.gz")
  backend_tar_b64        = filebase64("${path.module}/backend.tar.gz")
  frontend_script        = "${path.module}/user-data-frontend.sh"
  backend_script         = "${path.module}/user-data-backend.sh"
  public_vpc_cidr = one([
    for k, v in var.vpcs :
    v.cidr
    if v.vpc_type == "public"
  ])
}