#!/bin/bash

    echo you must be a centos user ! 

    echo updating yum

    yum update -y > /dev/null


    echo installing epel

    yum install -y epel-release > /dev/null


    SOFTWARE_LIST="dialog screen vim  wget links curl iftop iotop "


    echo installing sane software


    yum install -y $SOFTWARE_LIST > /dev/null


    #the y/n needs to be able to accept yes and no and Y and N


    echo "do you want to make a user ? [y/n]" #in quotes because [] seems to break things

    #read reads user input in this case it gets user input and puts it into the MAKEAUSER variable
    read MAKEAUSER   



   echo "do you want to make a user ? [y/n]" #in quotes because [] seems to break things

    #read reads user input in this case it gets user input and puts it into the MAKEAUSER variable
    read Makeauser  



    if [ $Makeauser == "y" ]; then #bash if statment and condition
     echo enter a username
     read   NAME
     adduser $NAME
     echo enter your password
     passwd $NAME --stdin  #--stdin is whatever the user enters
     echo yay the user $NAME was created !!!
     echo making the user a super user
     usermod -aG wheel $NAME
     echo I have added a the user $NAME
    else
 
    
    if [[ $docker_choice == "yes" ]]
    then
        echo "installing Docker"
fi

    if [[ $twofa_choice == "yes" ]]
    then
        echo "Installing 2fa"
        echo "we will be using TOTP, you can authenticate using any OATH tool, this process will produce a qr code"
        echo "you can scan the QR code using the google authenticator"
        yum install -y google-authenticator > /dev/null
        google-authenticator -t -d -f -r 3 -R 30 -W -Q utf8
        
        
    fi

  
