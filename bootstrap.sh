#!/bin/bash

# firewall
#firewall-cmd --permanent --zone=public --add-service=http
#firewall-cmd --reload
systemctl disable firewalld
systemctl stop firewalld

# disable selinux
setenforce 0
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config

# add third-party yum repo
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum update -y
yum upgrade -y

# redis
yum install -y redis
systemctl enable redis
systemctl start redis

# mariadb
curl -sS https://downloads.mariadb.com/MariaDB/mariadb_repo_setup | sudo bash
yum install -y MariaDB-server MariaDB-client
systemctl enable mariadb
systemctl start mariadb

# mysql 5.7
#rpm -Uvh https://repo.mysql.com/mysql57-community-release-el7.rpm
#yum install -y mysql-community-server
#systemctl enable mysqld
#systemctl start mysqld

# nginx
yum install -y nginx
rm -rf /etc/nginx/conf.d
ln -s /vagrant/nginx/conf.d/ /etc/nginx
sed -i "s/sendfile[ ][ ]*on/sendfile off/" /etc/nginx/nginx.conf
systemctl enable nginx
systemctl start nginx

# php 7.2
yum --enablerepo=remi,remi-php72 install -y php-cli php-fpm php-gd php-intl php-json php-mbstring php-mcrypt php-mysqlnd php-opcache php-pdo php-xml php-pecl-zip
sed -i "s/;date.timezone =/date.timezone = Asia\/Taipei/" /etc/php.ini
sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/php.ini
systemctl enable php-fpm
systemctl start php-fpm

# php 5.6
yum --enablerepo=remi install -y php56-php-cli php56-php-fpm php56-php-gd php56-php-intl php56-php-json php56-php-mbstring php56-php-mcrypt php56-php-mysqlnd php56-php-opcache php56-php-pdo php56-php-xml php56-php-pecl-zip
sed -i "s/listen = 127.0.0.1:9000/listen = 127.0.0.1:9001/" /opt/remi/php56/root/etc/php-fpm.d/www.conf
sed -i "s/;date.timezone =/date.timezone = Asia\/Taipei/" /opt/remi/php56/root/etc/php.ini
sed -i "s/memory_limit = 128M/memory_limit = 512M/" /opt/remi/php56/root/etc/php.ini
systemctl enable php56-php-fpm
systemctl start php56-php-fpm

# composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# ntp
yum install ntp -y
systemctl enable ntpd
systemctl start ntpd

# timezone
timedatectl set-timezone Asia/Taipei

# vim
yum install -y vim
sed -i -e "\$a\ " /etc/vimrc
sed -i -e "\$asyntax on" /etc/vimrc
sed -i -e "\$afiletype on" /etc/vimrc
sed -i -e "\$afiletype indent on" /etc/vimrc
sed -i -e "\$acolorscheme slate" /etc/vimrc
sed -i -e "\$aset nu" /etc/vimrc
sed -i -e "\$aset colorcolumn=90" /etc/vimrc
sed -i -e "\$aset history=100" /etc/vimrc
sed -i -e "\$aset number" /etc/vimrc
sed -i -e "\$aset hidden" /etc/vimrc
sed -i -e "\$aset hlsearch" /etc/vimrc
sed -i -e "\$aset showmatch" /etc/vimrc
sed -i -e "\$aset nowrap" /etc/vimrc
sed -i -e "\$aset tabstop=4" /etc/vimrc
sed -i -e "\$aset shiftwidth=4" /etc/vimrc
sed -i -e "\$aset expandtab" /etc/vimrc
sed -i -e "\$aset smartindent" /etc/vimrc
sed -i -e "\$aset autoindent" /etc/vimrc
sed -i -e "\$aautocmd BufWritePre * :%s/\s\+$//e" /etc/vimrc

# utilities
yum install -y wget htop
