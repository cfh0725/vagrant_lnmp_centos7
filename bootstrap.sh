#!/bin/bash

# yum repo
rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://centos7.iuscommunity.org/ius-release.rpm
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum update -y
yum upgrade -y

# nfs
#yum install -y nfs-utils
#systemctl enable nfs-server
#systemctl start nfs-server

# memcached
#yum install memcached
#systemctl enable memcached
#systemctl start memcached

# redis
yum install -y redis
systemctl enable redis
systemctl start redis

# mariadb
#yum install -y mariadb-server
#systemctl enable mariadb
#systemctl start mariadb

# mysql
rpm -ivh https://repo.mysql.com/mysql-community-release-el7-7.noarch.rpm
yum install -y mysql-community-server
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

# php 5.4
#yum --enablerepo=remi install php54-php-cli php54-php-fpm php54-php-gd php54-php-intl php54-php-json php54-php-mbstring php54-php-mcrypt php54-php-mysqlnd php54-php-opcache php54-php-pdo php54-php-xml php54-php-pecl-memcache php54-php-pecl-memcached php54-phpphp-pecl-zip php54-phpphp-pecl-xdebug -y
#sed -i "s/listen = 127.0.0.1:9000/listen = 127.0.0.1:9002/" /opt/remi/php54/root/etc/php-fpm.d/www.conf
#sed -i "s/;date.timezone =/date.timezone = Asia\/Taipei/" /opt/remi/php54/root/etc/php.ini
#sed -i "s/memory_limit = 128M/memory_limit = 512M/" /opt/remi/php54/root/etc/php.ini
#systemctl enable php54-php-fpm
#systemctl start php54-php-fpm

# php 5.6
yum install -y php56u-cli php56u-fpm php56u-gd php56u-intl php56u-json php56u-mbstring php56u-mcrypt php56u-mysqlnd php56u-opcache php56u-pdo php56u-xml php56-php-pecl-zip php56-php-pecl-zdebug
sed -i "s/listen = 127.0.0.1:9000/listen = 127.0.0.1:9001/" /etc/php-fpm.d/www.conf
sed -i "s/;date.timezone =/date.timezone = Asia\/Taipei/" /etc/php.ini
sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/php.ini
systemctl enable php-fpm
systemctl start php-fpm

# php 7
yum --enablerepo=remi install -y php70-php-cli php70-php-fpm php70-php-gd php70-php-intl php70-php-json php70-php-mbstring php70-php-mcrypt php70-php-mysqlnd php70-php-opcache php70-php-pdo php70-php-xml php70-php-pecl-zip php70-php-pecl-xdebug
sed -i "s/memory_limit = 128M/memory_limit = 512M/" /etc/opt/remi/php70/php.ini
systemctl enable php70-php-fpm
systemctl start php70-php-fpm

# composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

# nginx
yum install -y nginx
rm -rf /etc/nginx/conf.d
ln -s /vagrant/nginx/conf.d/ /etc/nginx
sed -i "s/sendfile[ ][ ]*on/sendfile off/" /etc/nginx/nginx.conf
systemctl enable nginx
systemctl start nginx

# vim
yum install -y vim
sed -i -e "\$a\ " /etc/vimrc
sed -i -e "\$asyntax on" /etc/vimrc
sed -i -e "\$aset nu" /etc/vimrc

# utilities
yum install -y wget htop net-tools git certbot

# disable firewall
systemctl disable firewalld
systemctl stop firewalld

# disable selinux
sed -i "s/SELINUX=enforcing/SELINUX=disabled/" /etc/selinux/config
reboot
