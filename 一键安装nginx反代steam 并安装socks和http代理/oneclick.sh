#!/bin/bash

# 判断是否需要安装 Socks5 代理
read -p "是否需要安装 Socks5 代理（0：否 1：是）：" socks5_flg

# Nginx
firewall-cmd --add-port=80/tcp --permanent
# HTTP
firewall-cmd --add-port=18779/tcp --permanent
# Socks5
firewall-cmd --add-port=15055/tcp --permanent
firewall-cmd --reload  

yum -y update
yum -y install epel-release
# yum -y install wget curl -y

# Nginx
yum -y install nginx
wget https://raw.githubusercontent.com/m18018230731/kantan-tools/master/%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85nginx%E5%8F%8D%E4%BB%A3steam%20%E5%B9%B6%E5%AE%89%E8%A3%85socks%E5%92%8Chttp%E4%BB%A3%E7%90%86/nginx.conf
mv -f nginx.conf /etc/nginx/nginx.conf
chmod 777 /etc/nginx/nginx.conf
nginx -s reload
service nginx start
systemctl enable nginx.service

# Tinyproxy
yum -y install tinyproxy
wget https://raw.githubusercontent.com/m18018230731/kantan-tools/master/%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85nginx%E5%8F%8D%E4%BB%A3steam%20%E5%B9%B6%E5%AE%89%E8%A3%85socks%E5%92%8Chttp%E4%BB%A3%E7%90%86/tinyproxy.conf
mv -f tinyproxy.conf /etc/tinyproxy/tinyproxy.conf
systemctl start tinyproxy.service
systemctl enable tinyproxy.service

# Socks5
if test ${socks5_flg} -gt 0
  wget https://raw.githubusercontent.com/qinghuas/socks5-install/master/socks5.sh;bash socks5.sh
  socks5 install
  socks5 user add rabproxy 12z991
  wget https://raw.githubusercontent.com/m18018230731/kantan-tools/master/%E4%B8%80%E9%94%AE%E5%AE%89%E8%A3%85nginx%E5%8F%8D%E4%BB%A3steam%20%E5%B9%B6%E5%AE%89%E8%A3%85socks%E5%92%8Chttp%E4%BB%A3%E7%90%86/ss5
  mv -f ss5 /etc/init.d/ss5
  socks5 start

# Completed
echo "Completed!"
