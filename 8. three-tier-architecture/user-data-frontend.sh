#!/bin/bash
set -eux

# Install nginx

sudo yum update -y
sudo yum install -y nginx
sudo systemctl start nginx

# Install packages
yum install -y tar gzip

mkdir -p /usr/share/nginx/

# -------- FRONTEND --------
cat <<'FRONTEND_TAR' | base64 -d |  tar -xzf - -C /usr/share/nginx/
${frontend_tar_b64}
FRONTEND_TAR

# -------- NGINX --------

cat <<'CONF' > /etc/nginx/conf.d/fullstack.conf
server {
        listen 80;
        server_name _;
        root /usr/share/nginx/frontend;

        location / {
                try_files $uri $uri/ = 404;
        }

        location /api/ {
                proxy_pass http://${backend_ip}:8080;
                proxy_http_version 1.1;
                proxy_set_header Host $host;
                proxy_set_header X-Real-IP $remote_addr;
                proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
                proxy_set_header X-Forwarded-Proto $scheme;

        }
}
CONF

sudo systemctl restart nginx

sleep 60

sudo systemctl restart nginx

sleep 30

sudo systemctl restart nginx

sleep 30

sudo systemctl restart nginx