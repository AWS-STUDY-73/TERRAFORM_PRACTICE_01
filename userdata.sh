#!/bin/bash
apt-get update
apt-get install nginx -y
echo "Hi Aakash" >/var/www/html/index.nginx-debian.html