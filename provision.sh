#!/bin/bash

#TODO have singluar software list as a variable ? 
#have command line options for installing certain apps ? eg ./test.sh --docker 


#detect distro
distro=$(lsb_release -i | cut -f 2-)


if [ "$distro" ==  *"Ubuntu"* ]
then


    # First Update all packages -y for no interactive
    apt-get update -y
    apt-get upgrade -y
    apt-get install htop denyhosts iotop fail2ban openssh-server vim sudo -y
    sed -i '/^PermitRootLogin[ \t]\+\w\+$/{ s//PermitRootLogin no/g; }' /etc/ssh/sshd_config

    if [ $(id -u) -eq 0 ]; then #root only
        read -s -p "Enter new root password: " rootpassword
        read -p "Enter a new user : " username
        read -s -p "Enter a password for this new user : " password
        egrep "^$username" /etc/passwd >/dev/null
        if [ $? -eq 0 ]; then
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
    else
        echo "Only root may add a user to the system"
        exit 2
    fi
    read -p "Set a hostname for your server: (etc.. z.mk) don't use _ " myhostname
    hostnamectl set-hostname $myhostname

    # Need to restart SSH for root password to take affect.
    service ssh restart

else
#TODO rewrite this crap 

    echo you must be a centos user ! 

    echo updating yum

    yum update -y


    echo installing epel

    yum install -y epel-release


    SOFTWARE_LIST="screen vim  wget links curl "


    echo installing sane software


    yum install -y $SOFTWARE_LIST


    #the y/n needs to be able to accept yes and no and Y and N


    echo "do you want to make a user ? [y/n]" #in quotes because [] seems to break things

    #read reads user input in this case it gets user input and puts it into the MAKEAUSER variable
    read MAKEAUSER   



    if [ $MAKEAUSER == y ] #bash if statment and condition
    then
       echo enter a username
          read NAME
             adduser $NAME
                echo enter your password
                   passwd $NAME --stdin  #--stdin is whatever the user enters
                      echo yay the user $NAME was created !!!
                  fi #end of if statment

                  echo complete

fi

