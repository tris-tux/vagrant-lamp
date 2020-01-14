#! /usr/bin/env bash

echo -e "\n\n=======================================\n"
echo -e "Mulai provisioning.\n"
echo -e "=======================================\n\n"

echo -e " --> Updating the server.\n\n"
sudo apt-get update >/dev/null 2>&1
sudo apt-get upgrade >/dev/null 2>&1

echo -e "\n --> Installing cURL.\n\n"
sudo apt-get install -u curl >/dev/null 2>&1

echo -e "\n --> Installing MySQL tools.\n\n"
sudo apt-get install -y mysql-client >/dev/null 2>&1

echo -e "\n --> Installing Apache.\n\n"
sudo apt-get install -y apache2 >/dev/null 2>&1
echo "ServerName localhost" >> /etc/apache2/apache2.conf

echo -e "\n --> Installing PHP 7.3 and common modules.\n\n"
sudo apt-get install -y python-software-properties >/dev/null 2>&1
sudo add-apt-repository -y ppa:ondrej/php >/dev/null 2>&1
sudo apt-get update >/dev/null 2>&1

sudo apt-get install -y php7.3 >/dev/null 2>&1
sudo apt-get install -y php-pear >/dev/null 2>&1
sudo apt-get install -y php7.3-curl >/dev/null 2>&1
sudo apt-get install -y php7.3-dev >/dev/null 2>&1
sudo apt-get install -y php7.3-gd >/dev/null 2>&1
sudo apt-get install -y php7.3-mbstring >/dev/null 2>&1
sudo apt-get install -y php7.3-zip >/dev/null 2>&1
sudo apt-get install -y php7.3-mysql >/dev/null 2>&1
sudo apt-get install -y php7.3-xml >/dev/null 2>&1

echo -e "\n --> Installing MySQL server and configuration it to use 'root' as password.\n\n"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get -q -y install mysql-server >/dev/null 2>&1
ROOT_DB_PASSWORD="mypass"

echo -e "\n --> Update configuration to make it accessible from host via root.\n"
sudo service mysql restart
sudo service apache2 reload

echo -e "\n --> Done \n\n"

echo -e "=========================================\n"
echo -e "Finished provisioning.\n"
echo -e "========================================\n\n"
echo -e "\n\n"



