#sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
#sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

dnf update -y
yum install wget -y
wget https://nginx.org/packages/centos/8/x86_64/RPMS/nginx-1.18.0-2.el8.ngx.x86_64.rpm
rpm -ivh nginx-1.18.0-2.el8.ngx.x86_64.rpm
rm -f nginx-1.18.0-2.el8.ngx.x86_64.rpm
systemctl enable nginx
systemctl start nginx

systemctl daemon-reload
dnf install dnf-utils http://rpms.remirepo.net/enterprise/remi-release-8.rpm -y
dnf module reset php -y
dnf module enable php:remi-8.1 -y
dnf update -y
dnf install php php-fpm  php-gd php-mysqlnd -y

systemctl enable php-fpm
systemctl start php-fpm

dnf install php-cli php-json php-zip wget unzip -y
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('sha384', 'composer-setup.php') === '55ce33d7678c5a611085589f1f3ddf8b3c52d662cd01d4ba75c0ee0459970c2200a51f492d557530c71c15d8dba01eae') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

mv composer.phar /usr/local/bin/composer