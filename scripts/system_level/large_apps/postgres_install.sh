#!/usr/bin/bash

# postgres 16 client and full
# ref: https://www.postgresql.org/download/linux/ubuntu/

sudo apt install -y curl ca-certificates
sudo curl -fsSL https://www.postgresql.org/media/keys/ACCC4CF8.asc \
    -o /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc

sudo apt-key add /usr/share/postgresql-common/pgdg/apt.postgresql.org.asc

echo "=============> add postgres keys done"

sudo install -d /usr/share/postgresql-common/pgdg
echo "deb [signed-by=/usr/share/postgresql-common/pgdg/apt.postgresql.org.asc] https://apt.postgresql.org/pub/repos/apt \
    $(. /etc/os-release && echo "$UBUNTU_CODENAME")-pgdg main" | \
    sudo tee /etc/apt/sources.list.d/pgdg.list
echo "=============> add postgres source list done"

sudo apt update
# sudo apt -y install postgresql
sudo apt -y install postgresql-client-16
