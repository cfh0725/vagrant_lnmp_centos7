# vagrant_lemp_centos7

setting up a local web develop environment of centos,php-fpm,nginx,mariadb,redis with vagrant

# requirements
1. virtualbox
2. vagrant

# installation
1. clone the repo
2. cd to vagrant/
3. run "vagrant up" in command line
4. add two lines to "/etc/hosts" on local host machine
<pre>
tool.test    192.168.33.10
app.test     192.168.33.10
</pre>

# usage
open your broswer and goto
1. http://tool.test/pi.php to check phpinfo
2. http://tool.test/adminer.php to mysql web gui (provided by https://www.adminer.org/)
3. http://app.test to your project home (web root is set to "projects/app/", you can change it in "nginx/conf.d/vhosts.conf")

# php
1. php-fpm 7.2 listening on port 9000
2. php-fpm 5.6 listening on port 9001

# mariadb
1. root password is "show_me_the_data"
2. data stores in "databases/mysql/data"

# known issue
if nginx always returns default testing page, just restart nginx.
