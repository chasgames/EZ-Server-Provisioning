#!/bin/bash


echo "Please make sure you are Root user because we need it."
echo "Detecting Linux Distro"
if cat /etc/*-release | grep ubuntu >/dev/null; then

echo "Ubuntu Provisioning"
curl -L https://raw.githubusercontent.com/chasgames/EZ-Server-Provisioning/master/ubuntu.sh | bash

elif cat /etc/*-release | grep centos >/dev/null; then

echo "CentOS Provisioning"
curl -L https://raw.githubusercontent.com/chasgames/EZ-Server-Provisioning/master/centos.sh | bash

else
	echo "We don't have support for your weird distro"
fi

# bash -c "$(wget -O - https://raw.githubusercontent.com/chasgames/EZ-Server-Provisioning/master/provision.sh)"
#wget https://raw.githubusercontent.com/chasgames/EZ-Server-Provisioning/master/testdialog.sh -O ./prov.sh
#chmod +x prov.sh
#./prov.sh

#test