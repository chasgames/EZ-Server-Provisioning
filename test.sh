#!/bin/sh

# First Update all packages -y for no interactive
apt-get update -y
apt-get upgrade -y
apt-get install htop denyhosts iotop fail2ban openssh-server -y
sed -i '/^PermitRootLogin[ \t]\+\w\+$/{ s//PermitRootLogin no/g; }' /etc/ssh/sshd_config

if [ $(id -u) -eq 0 ]; then #root only
	read -s -p "Enter new root password: " rootpassword
	echo "root:$rootpassword" | chpasswd
	read -p "Enter a new user : " username
	read -s -p "Enter a password for this new user : " password
	egrep "^$username" /etc/passwd >/dev/null
	if [ $? -eq 0 ]; then
		echo "$username exists!"
		exit 1
	else
		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
		useradd -m -p $pass $username
		usermod -aG sudo $username
		[ $? -eq 0 ] && echo "User has been added to system.. oh and it's a sudo!" || echo "Failed to add a user!"
	fi
else
	echo "Only root may add a user to the system"
	exit 2
fi
read -p "Set a hostname for your server: (etc.. z.mk) don't use _ " myhostname
hostnamectl set-hostname $myhostname

# Need to restart SSH for root password to take affect.
service ssh restart
