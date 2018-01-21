# vagrant_lemp_centos7

setting up a local web develop environment of centos,php-fpm,nginx,mysql,redis with vagrant

# requirements
1. virtualbox
2. vagrant

# installation
1. clone the repo
2. run "vagrant up" in command line
3. add two lines to "/etc/hosts" on local machine
<pre>
tool.test    192.168.33.10
app.test     192.168.33.10
</pre>

# usage
open your broswer and goto
1. http://tool.test/pi.php to check phpinfo
2. http://tool.test/adminer.php to mysql web gui (provided by https://www.adminer.org/)
3. http://app.test to your project home (web root is set to "public/", you can change it in "nginx/conf.d/vhosts.conf")

# php
1. php-fpm 7.2 listening on port 9000
2. php-fpm 5.6 listening on port 9001

# mysql
root password is empty

# known issue
if nginx alway returns default testing page, just restart nginx.
