#!/usr/bin/env bash
echo ">> Provisioning VM for Placeholder Project"

export DEBIAN_FRONTEND=noninteractive

echo ">> Populating database with default data"
cd /home/vagrant/placeholder.com
php artisan migrate --seed

echo ">> Copying my.cnf"
sudo cp /home/vagrant/provision/my.cnf /etc/mysql/my.cnf
service mysql restart

echo ">> copying laravel env"
cp /home/vagrant/placeholder.com/laravel/.env.example /home/vagrant/placeholder.com/laravel/.env
cd /home/vagrant/placeholder.com/laravel

echo ">> composer install"
composer install --verbose

echo ">> npm install"
npm install

echo ">> moving to Placeholder folder"
cd /home/vagrant/placeholder.com
npm install

echo ">> Installing system tools"
apt-get install -y htop


echo ">> Finished provision!"
