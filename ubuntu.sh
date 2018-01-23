#!/bin/bash

#TODO have singluar software list as a variable ? 
#have command line options for installing certain apps ? eg ./test.sh --docker 
curl -L https://raw.githubusercontent.com/chasgames/EZ-Server-Provisioning/master/testdialog.sh | bash
echo "You have decided: $docker_choice"
echo $testing
    # First Update all packages -y for no interactive
    echo "Congratulations for choosing the best linux distribution"
    apt-get update -y
    apt-get upgrade -y
    apt-get install htop denyhosts iotop iftop openssh-server vim sudo chrony curl wget -y
    echo "Configuring packages"
    echo "Removing SSH Root Login"
    sed -i '/^PermitRootLogin[ \t]\+\w\+$/{ s//PermitRootLogin no/g; }' /etc/ssh/sshd_config
    # Configuring Chrony, way better than NTPd, much more reliable and stays in Sync.
    echo "Maybe add some time sources here"
    
    read -s -p "Enter new root password: " rootpassword
        read -p "Enter a new user : " username
        read -s -p "Enter a password for this new user : " password
if cat /etc/passwd | grep $username >/dev/null; then
            echo "$username exists!"
            exit 1
        else
            rootpass=$(perl -e 'print crypt($ARGV[0], "password")' $rootpassword)
            echo "root:$rootpass" | chpasswd		
            pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
            useradd -m -p $pass $username
            usermod -aG sudo $username
            [ $? -eq 0 ] && echo "User has been added to system.. oh and it's a sudo!" || echo "Failed to add a user!"
        fi
   
    read -p "Set a hostname for your server: (etc.. z.mk) don't use _ " myhostname
    hostnamectl set-hostname $myhostname

    # Need to restart SSH for root password to take affect.
    service ssh restart
    

    read -p "Do you want Docker? [y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo "installing Docker"
    fi
    
    read -p "Do you want Duo? [y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo "installing Duo"
    fi
