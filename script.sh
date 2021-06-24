#! /bin/bash
sudo yum update -y
sudo amazon-linux-extras install nginx1 -y
sudo service nginx enable
sudo service nginx start

