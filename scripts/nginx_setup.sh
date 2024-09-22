#!/bin/bash
#scripts/nginx_setup.sh

# update and upgrade system
sudo apt update -y && sudo apt upgrade -y

# install nginx
sudo apt install -y nginx

# start and enable
sudo systemctl start nginx
sudo systemctl enable nginx

# verify
sudo systemctl status nginx

