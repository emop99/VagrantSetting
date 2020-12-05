#!/bin/sh

wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
wget https://repo.ius.io/ius-release-el7.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
rpm -ivh ius-release-el7.rpm
yum --enablerepo=ius-archive install -y php74*
systemctl start php-fpm
systemctl enable php-fpm
rm -f epel-release-latest-7.noarch.rpm
rm -f ius-release-el7.rpm
