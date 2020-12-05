#!/bin/sh

# yum update
yum -y update
# wget install
yum -y install wget

# php install
wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
wget https://repo.ius.io/ius-release-el7.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
rpm -ivh ius-release-el7.rpm
yum --enablerepo=ius-archive install -y php74*
systemctl start php-fpm
systemctl enable php-fpm
rm -f epel-release-latest-7.noarch.rpm
rm -f ius-release-el7.rpm

# nginx install
yes|cp -arpf /VagrantSetting/ngnix.repo /etc/yum.repos.d/CentOS-ngnix.repo
yum -y install nginx
systemctl start nginx
systemctl enable nginx
systemctl restart nginx

# mariaDB install
yes|cp -arpf /VagrantSetting/mariaDB.repo /etc/yum.repos.d/MariaDB.repo
yum makecache fast
yum -y install MariaDB-server MariaDB-client
systemctl start mariadb
systemctl enable mariadb
mysql -e "create database mariadb"
mysql -e "create user 'vagrant'@'localhost' identified by 'qlalfqjsgh1@'"
mysql -e "GRANT USAGE ON *.* TO 'vagrant'@'%' IDENTIFIED BY 'qlalfqjsgh1@'"
mysql -e "grant all privileges on mariadb.* to 'vagrant'@'%' identified by 'qlalfqjsgh1@'"
mysql -e "flush privileges"

sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
sed -i 's/$server_name;/$http_host;/g' /etc/nginx/fastcgi_params
