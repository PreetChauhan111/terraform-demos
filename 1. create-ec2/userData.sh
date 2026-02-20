#!/bin/bash
set -eux

# Install nginx

sudo yum update -y
sudo yum install -y nginx
sudo systemctl start nginx

# Install packages
yum install -y tar gzip

mkdir -p /var/www/

# -------- FRONTEND --------
cat <<'FRONTEND_TAR' | base64 -d |  tar -xzf - -C /var/www/
${frontend_tar_b64}
FRONTEND_TAR

# -------- NGINX --------

cat <<'CONF' > /etc/nginx/conf.d/fullstack.conf
server {
  listen 80;
  root /var/www/frontend;
  index index.html;

  location / {
    try_files $uri $uri/ =404;
  }
}
CONF

systemctl restart nginx