#!/bin/bash
set -eux

##################################
# 1. Export DB environment vars
##################################

cat <<EOF >> /etc/environment
DB_HOST=${db_host}
DB_USER=${db_username}
DB_PASSWORD=${db_password}
DB_NAME=${db_name}
EOF

source /etc/environment

##################################
# 2. Install packages
##################################

sudo apt update
sudo apt install -y tar gzip nodejs npm mysql-client
mkdir -p /home/ubuntu/backend

##################################
# 3. Extract backend code
##################################

cat <<'BACKEND_TAR' | base64 -d | tar -xzf - -C /home/ubuntu/backend
${backend_tar_b64}
BACKEND_TAR

##################################
# Correcting folder structure
##################################

cd /home/ubuntu/backend/
sudo mv backend/* ./
sudo rm -rf backend

##################################
# 6. Run backend app
##################################

sudo npm install
nohup node server.js > /var/log/backend.log 2>&1 &

##################################
# 5. Initialize database (optional)
##################################

mysql -h "$DB_HOST" -u "$DB_USER" -p"$DB_PASSWORD" <<SQL
USE appdb;
CREATE TABLE test (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50)
);
INSERT INTO test (name) VALUES ('Hello from RDS');
SQL

nohup node server.js > /var/log/backend.log 2>&1 &