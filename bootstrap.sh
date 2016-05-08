#!/bin/bash

# add yum repo
yum install epel-release -y
yum install https://centos7.iuscommunity.org/ius-release.rpm -y

yum update -y
yum upgrade -y

# nfs
yum install nfs-utils -y
systemctl enable nfs-server
systemctl start nfs-server

# mariadb
#yum install mariadb-server -y
#systemctl enable mariadb
#systemctl start mariadb

# mysql
rpm -ivh https://repo.mysql.com/mysql-community-release-el7.rpm
yum install mysql-community-server -y

systemctl enable mysqld
systemctl start mysqld

mysql -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('asdflkjh') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
FLUSH PRIVILEGES;
EOF

# php 7
yum install php70u-cli php70u-fpm php70u-gd php70u-json php70u-mbstring php70u-mcrypt php70u-mysqlnd php70u-opcache php70u-pdo php70u-pgsql php70u-intl php70u-soap php70u-xml php70u-pecl-zip -y
#sed -i "s/listen = 127.0.0.1:9000/listen = 127.0.0.1:9001/" /etc/php-fpm.d/www.conf
sed -i "s/;date.timezone =/date.timezone = Asia\/Taipei/" /etc/php.ini
sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/php.ini
systemctl enable php-fpm
systemctl start php-fpm

# composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# nginx
yum install nginx -y
rm -rf /etc/nginx/conf.d
ln -s /vagrant/nginx/conf.d/ /etc/nginx
sed -i "s/sendfile[ ][ ]*on/sendfile off/" /etc/nginx/nginx.conf
systemctl enable nginx
systemctl start nginx

#redis
sudo yum install redis -y
systemctl enable redis
systemctl start redis

# firewall
systemctl disable firewalld
systemctl stop firewalld

# vim
yum install vim -y
sed -i -e "\$a\ " /etc/vimrc
sed -i -e "\$asyntax on" /etc/vimrc
sed -i -e "\$aset nu" /etc/vimrc

# utilities
yum install wget git htop net-tools -y

