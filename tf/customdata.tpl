#!/bin/bash
sudo apt-get update
sudo apt-get install python3 -y
sudo apt-get install nginx -y
sudo sytemctl enable nginx
sudo systemctl start nginx