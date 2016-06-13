#!/bin/bash

# add yum repo
rpm -Uvh http://download.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://dl.iuscommunity.org/pub/ius/stable/CentOS/7/x86_64/ius-release-1.0-14.ius.centos7.noarch.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm

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
rpm -ivh http://repo.mysql.com/mysql-community-release-el7-7.noarch.rpm
yum install mysql-community-server -y
systemctl enable mysqld
systemctl start mysqld

mysql -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
FLUSH PRIVILEGES;
EOF

# php 5.6
yum install php56u-cli php56u-fpm php56u-gd php56u-json php56u-mbstring php56u-mcrypt php56u-mysqlnd php56u-opcache php56u-pdo php56u-pgsql php56u-xml php56-php-pecl-zip php56u-pecl-memcache php56u-pecl-memcached -y
sed -i "s/;date.timezone =/date.timezone = Asia\/Taipei/" /etc/php.ini
sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/php.ini
systemctl enable php-fpm
systemctl start php-fpm

# php 7
yum install php71-php-cli php71-php-fpm php71-php-gd php71-php-json php71-php-mbstring php71-php-mcrypt php71-php-mysqlnd php71-php-opcache php71-php-pdo php71-php-pgsql php71-php-xml php71-php-pecl-zip -y
sed -i "s/listen = 127.0.0.1:9000/listen = 127.0.0.1:9001/" /etc/opt/remi/php71/php-fpm.d/www.conf
sed -i "s/;date.timezone =/date.timezone = Asia\/Taipei/" /etc/opt/remi/php71/php.ini
sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/opt/remi/php71/php.ini
systemctl enable php71-php-fpm
systemctl start php71-php-fpm

# composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# redis
yum install redis -y
systemctl enable redis
systemctl start redis

# nginx
yum install nginx -y
rm -rf /etc/nginx/conf.d
ln -s /vagrant/nginx/conf.d/ /etc/nginx
sed -i "s/sendfile[ ][ ]*on/sendfile off/" /etc/nginx/nginx.conf
systemctl enable nginx
systemctl start nginx

# firewall
systemctl disable firewalld
systemctl stop firewalld

# vim
yum install vim -y
sed -i -e "\$a\ " /etc/vimrc
sed -i -e "\$asyntax on" /etc/vimrc
sed -i -e "\$aset nu" /etc/vimrc

# utilities
yum install wget git htop net-tools vim -y

# selinux
sudo sed -i 's/enforcing/disabled/g' /etc/selinux/config
