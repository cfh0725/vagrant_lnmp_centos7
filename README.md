# vagrant_lemp_centos7

setting up a local web develop environment with centos7,php7,mysql,nginx using vagrant

# requirements
1. vagrant

# installation
1. clone the repo  
2. run "vagrant up" in command line  
3. edit your hosts file add two lines:  
tool.dev    192.168.33.10  
app.dev     192.168.33.10

# usage
open your broswer and goto  
1. http://tool.dev/pi.php to check phpinfo  
2. http://tool.dev/adminer.php to mysql web gui (provided by https://www.adminer.org/)  
3. http://app.dev to your php project (web root is set to "public/", you can change it in "nginx/conf.d/vhosts.conf")  

# mysql
root password is empty
