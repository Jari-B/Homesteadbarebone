#!/bin/bash

echo "Gonna install the dependencies ( composer )"
hash composer
if [ $? -ne 0 ]
then
	echo "Installing composer"
	# figure out OS
	if [[ $(uname) = *"Darwin"* ]]; then
		# OSX
		hash brew
		if [ $? -ne 0 ]
		then
			echo "Why do you not have brew installed?"
			echo "Installing brew"
			ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
		fi
		# add brew taps
		echo "adding brew taps"
		brew tap homebrew/dupes
		brew tap homebrew/php
		echo "installing php"
		brew install php74
		echo "installing composer"
		brew install composer
		echo "Install composer dependencies"
		composer install

	elif [[ $(uname) = *"Linux"* ]]; then
		# linux
		echo "this is a linux box and kyle was too lazy to set that up \n"
		echo "since you're running linux, you probably know how to install php & composer"
		echo "do that, also: next command is gonna fail"
		echo "then feel free to updaate this script."

	elif [[ $(uname) = *"NT-10"* ]]; then
		echo "It seems you are running on windows 10 (via git bash)"
		echo "Can you please ensure php7 and composer are installed?"
		echo "http://kizu514.com/blog/install-php7-and-composer-on-windows-10/"
		read -p "Press enter to continue"
		echo "Now that you have installed php7 and composer, please close this bash"
		echo "Open a new git bash, and re run this script"
		echo "please consider developing on ubuntu instead."
		exit 0
	else
		echo "Unknown operating system"
		echo "maybe you are running this via cmd (windows)?"
		echo "if so, please use git bash"
		echo "please consider developing on ubuntu instead."
		exit 0
	fi
else
	composer install
fi
hash vagrant
if [ $? -ne 0 ]
then
    echo "Please install vagrant and then run 'vagrant up'"
else
	vagrant up
fi
echo "Editing hosts file ( may need password)"

if [[ $(uname) = *"NT-10"* ]]; then
	echo "please add the following line to C:\Windows\System32\drivers\etc\hosts"
	echo "192.168.10.10 placeholder.site"
else
	echo "192.168.10.10 placeholder.site" | sudo tee -a /etc/hosts
	echo "hosts file updated"
fi

exit 0
