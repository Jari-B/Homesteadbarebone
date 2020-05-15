#!/usr/bin/env bash
echo ">> Provisioning VM for Placeholder Project"

export DEBIAN_FRONTEND=noninteractive

echo ">> Populating database with default data"
cd /home/vagrant/lumenbarebone
php artisan migrate --seed

echo ">> copying laravel env"
cp /home/vagrant/lumenbarebone/.env.example /home/vagrant/lumenbarebone/.env
cd /home/vagrant/lumenbarebone

echo ">> composer install"
composer install --verbose

echo ">> Finished provision!"
