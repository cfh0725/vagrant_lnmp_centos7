#!/bin/bash

rpm -Uvh http://download.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -Uvh https://dl.iuscommunity.org/pub/ius/stable/CentOS/7/x86_64/ius-release-1.0-14.ius.centos7.noarch.rpm

# update
yum update -y
yum upgrade -y

# utilities
yum install -y nfs-utils
systemctl enable nfs-server
systemctl start nfs-server

# mariadb
yum install -y mariadb-server
systemctl enable mariadb
systemctl start mariadb

# mysql
#rpm -ivh http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
#yum install -y mysql-community-server
#systemctl enable mysqld
#systemctl start mysqld

mysql -u root <<-EOF
UPDATE mysql.user SET Password=PASSWORD('') WHERE User='root';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost', '127.0.0.1', '::1');
DELETE FROM mysql.user WHERE User='';
DROP DATABASE test;
DELETE FROM mysql.db WHERE Db='test' OR Db='test\_%';
FLUSH PRIVILEGES;
EOF

# php 5.6
#yum install -y php56u-cli php56u-fpm php56u-gd php56u-json php56u-mbstring php56u-mcrypt php56u-mysqlnd php56u-opcache php56u-pdo php56u-pgsql php56u-xml
#systemctl enable php-fpm
#systemctl start php-fpm

# php 7
rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-7.rpm
yum --enablerepo=remi install -y php70-php-cli php70-php-fpm php70-php-gd php70-php-json php70-php-mbstring php70-php-mcrypt php70-php-mysqlnd php70-php-opcache php70-php-pdo php70-php-pgsql php70-php-xml php70-php-pecl-zip
systemctl enable php70-php-fpm
systemctl start php70-php-fpm

# nginx
yum install -y nginx
rm -rf /etc/nginx/conf.d
ln -s /vagrant/nginx/conf.d/ /etc/nginx
sed -i "s/sendfile[ ][ ]*on/sendfile off/" /etc/nginx/nginx.conf
systemctl enable nginx
systemctl start nginx

# firewall
systemctl disable firewalld
systemctl stop firewalld

# vim
yum install -y vim
sed -i -e "\$a\ " /etc/vimrc
sed -i -e "\$asyntax on" /etc/vimrc
sed -i -e "\$aset nu" /etc/vimrc
