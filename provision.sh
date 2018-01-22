#!/bin/bash

#TODO have singluar software list as a variable ? 
#have command line options for installing certain apps ? eg ./test.sh --docker 


#detect distro
#might have to change this, dont think it is default on ubuntu
echo "Please make sure you are Root user because we need it."
echo "Detecting Linux Distro"
if cat /etc/*-release | grep ubuntu >/dev/null; then


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

else
###                        MARKS SECTION STARTS HERE                               ###
###
###
######################################################################################
#TODO rewrite Marks Crap

    echo you must be a centos user ! 

    echo updating yum

    yum update -y > /dev/null


    echo installing epel

    yum install -y epel-release > /dev/null


    SOFTWARE_LIST="screen vim  wget links curl iftop iotop "


    echo installing sane software


    yum install -y $SOFTWARE_LIST > /dev/null


    #the y/n needs to be able to accept yes and no and Y and N


    echo "do you want to make a user ? [y/n]" #in quotes because [] seems to break things

    #read reads user input in this case it gets user input and puts it into the MAKEAUSER variable
    read MAKEAUSER   



    if [ $MAKEAUSER -eq  y ] #bash if statment and condition
    then
       echo enter a username
       read -s -p  NAME
       adduser $NAME
       echo enter your password
       passwd $NAME --stdin  #--stdin is whatever the user enters
       echo yay the user $NAME was created !!!
       echo making the user a super user
       usermod -aG wheel $NAME
       echo I have added a the user $NAME
    fi #end of if statment
    
    
    read -p "Do you want Docker? [y/n] " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY =~ ^[Yy]$ ]]
    then
        echo "installing Docker"
fi

    read -p "do you want 2fa? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ $REPLY == ^[Yy]$ ]]
    then
        echo "Installing 2fa"
        echo "we will be using TOTP, you can authenticate using any OATH tool, this process will produce a qr code"
        echo "you can scan the QR code using the google authenticator"
        yum install -y google-authenticator > /dev/null
        google-authenticator -t -d -f -r 3 -R 30 -W -Q utf8
        
        
    fi

  

fi

