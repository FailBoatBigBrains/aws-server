#!/bin/bash
sudo apt install make curl -y

curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

sudo curl -L "https://github.com/docker/compose/releases/download/1.26.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

rm get-docker.sh

curl -LJO https://raw.githubusercontent.com/alinmear/docker-conanexiles/master/docker-compose.yml


file_string=$(echo -e "$(cat <<"EOF"
up:
\tsudo docker-compose up -d
down:
\tsudo docker-compose down
logs:
\tsudo docker-compose logs -f
EOF
)")

echo "$file_string" > /home/ubuntu/Makefile