#!/usr/bin/env bash

echo ">> running composer install"
cd /home/vagrant/lumenbarebone
composer install

php artisan key:generate
php artisan migrate

echo ">> Going to check if basic testing is setup"
pwd
PHP_UNIT=./phpunit.xml
if [[ -f "$PHP_UNIT" ]]; then
    sudo mv phpunit.xml tests/phpunit.xml
fi

echo ">> Checking if pre-commit hook is setup correctly"
PRE_COMMIT=/.git.hooks/pre-commit
if [[ ! -f "$PRE_COMMIT" ]]; then
    echo "Please run the download-pre-commit-hook.sh in the lumen folder."
fi

echo ">> Finished patching!"
