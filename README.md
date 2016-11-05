# vagrant_lemp_centos7

setting up a local web develop environment with centos7,php-fpm7,php-fpm5.6,nginx,mysql,redis using vagrant

# requirements
1. virtualbox
2. vagrant

# installation
1. clone the repo  
2. run "vagrant up" in command line  
3. add two lines to "/etc/hosts" on local machine 
tool.dev    192.168.33.10  
app.dev     192.168.33.10

# usage
open your broswer and goto  
1. http://tool.dev/pi.php to check phpinfo  
2. http://tool.dev/adminer.php to mysql web gui (provided by https://www.adminer.org/)  
3. http://app.dev to your project home (web root is set to "public/", you can change it in "nginx/conf.d/vhosts.conf")  

# mysql
root password is empty
