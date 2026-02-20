locals {
  frontend_tar_b64 = filebase64("${path.module}/frontend.tar.gz")
  nginx_tar_b64    = filebase64("${path.module}/nginx.tar.gz")
}
