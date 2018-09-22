#!/bin/bash

# Definition of the error function
throwError () {
    echo "========================== $1 failed ==========================";
    exit 1;
}

# Update the system
sudo apt-get update || { throwError 'Update the system'; }

# Install Apache Web Server
yes | sudo apt-get install apache2 apache2-utils || { throwError 'Install Apache Web Server - install'; }
sudo systemctl enable apache2 || { throwError 'Install Apache Web Server - enable'; }
sudo systemctl start apache2 || { throwError 'Install Apache Web Server - start'; }

# Install MySQL Database Server
sudo apt-get install pwgen || { throwError 'Install MySQL Database Server - pwgen'; }
password=$(pwgen 13 1) || { throwError 'Install MySQL Database Server - password'; }
yes | sudo apt-get install mysql-client mysql-server || { throwError 'Install MySQL Database Server - install'; }
sudo mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY '$password';" || { throwError 'Install MySQL Database Server - password'; }

# Install PHP and Modules
yes | sudo add-apt-repository ppa:ondrej/php || { throwError 'Install PHP and Modules - add-apt-repository'; }
yes | sudo apt-get install php7.0 php7.0-mysql libapache2-mod-php7.0 php7.0-cli php7.0-cgi php7.0-gd || { throwError 'Install PHP and Modules - install'; }

# Install WordPress CMS
cd /tmp && wget -c http://wordpress.org/latest.tar.gz || { throwError 'Install WordPress CMS - wget'; }
tar -xzvf latest.tar.gz || { throwError 'Install WordPress CMS - tar'; }
sudo rsync -av wordpress/* /var/www/html/ || { throwError 'Install WordPress CMS - rsync'; }
sudo rm /var/www/html/index.html || { throwError 'Install WordPress CMS - rm'; }
sudo chown -R www-data:www-data /var/www/html/ || { throwError 'Install WordPress CMS - chown'; }
sudo chmod -R 755 /var/www/html/ || { throwError 'Install WordPress CMS - chmod'; }

# Create WordPress Database
mysql -u root -p"$password" -e "CREATE DATABASE wordpress;" || { throwError 'Create WordPress Database - CREATE'; }
mysql -u root -p"$password" -e "GRANT ALL PRIVILEGES ON wp_myblog.* TO 'root'@'localhost' IDENTIFIED BY '$password';" || { throwError 'Create WordPress Database - GRANT'; }
mysql -u root -p"$password" -e "FLUSH PRIVILEGES;" || { throwError 'Create WordPress Database - FLUSH'; }

echo "============================== mysql =============================="
echo "database name: wordpress"
echo "user name: root"
echo "password (user root): $password"
echo "============================== mysql =============================="
