# ubuntu-wordpress-install
WordPress installation script for Ubuntu 16.10 / 16.04 Server
# install
```
git clone https://github.com/antoinealej/ubuntu-wordpress-install
cd ubuntu-wordpress-install
chmod +rx wordpress.sh
./wordpress.sh
```

# usage
Access your WordPress application from your browser on `{YOUR_IP}:80` or `{YOUR_IP}` and configure your connection to the database using the info at the end of the script execution logs 

Example:
```
============================== mysql ==============================
database name: wordpress
user name: root
password (user root): engieCe9siToh
============================== mysql ==============================
```

# What is the script doing?
1. Install Apache Web Server
2. Install MySQL Database Server
3. Install PHP and Modules
4. Install WordPress CMS
5. Create WordPress Database

# Source
1. [Install WordPress 4.9 On Ubuntu 16.10 / 16.04 Server](https://www.tecmint.com/install-wordpress-on-ubuntu-16-04-with-lamp/ "tecmint.com")
2. [Execute MySQL query from bash script](https://stackoverflow.com/questions/42223657/change-mysql-root-user-password-using-shell-script "stackoverflow.com")
