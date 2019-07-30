# vagrant_lnmp_centos7

setting up a local web develop environment of centos,php-fpm,nginx,mariadb,redis with vagrant

# requirements
1. virtualbox
2. vagrant

# installation
1. clone the repo
2. cd to vagrant/
3. run "vagrant up" at host to booting up guest vm
4. add two lines to "/etc/hosts" at host
<pre>
tools.test    192.168.33.10
app.test     192.168.33.10
</pre>

# usage
open your broswer and goto
1. http://tools.test/pi.php to check phpinfo
2. http://tools.test/adminer.php to mysql web gui (provided by https://www.adminer.org/)
3. http://app.test to your project home (web root is set to "projects/app/", you can change it in "nginx/conf.d/vhosts.conf")

# php
1. php-fpm 7.3 listening on port 9073
2. php-fpm 5.6 listening on port 9056

# mariadb
1. root password is "SHOW_ME_THE_DATA"

# known issue
if nginx always returns default testing page, just restart nginx.
