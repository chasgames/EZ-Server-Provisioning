#!/bin/bash

echo "Congratulations for choosing the best linux distribution"
apt update -y
apt upgrade -y
apt-get install dialog htop denyhosts iotop iftop openssh-server vim sudo tree chrony curl wget man ncdu screen ranger apt-transport-https ca-certificates software-properties-common -y
source <(curl -s https://raw.githubusercontent.com/chasgames/EZ-Server-Provisioning/master/questions.sh)
if [ $cancel_catch -eq 1 ]; then
    echo "ABORT ABORT - You cancelled something"
    exit 1
fi
if [ $rootpw_choice != $rootpwconfirm_choice ]; then
    echo "ABORT ABORT - Root password mistype"
    exit 1
fi
#echo $cancel_catch
#echo $testing
#echo $hostname_choice
#echo $rootpw_choice
#echo $rootpwconfirm_choice
#echo $newusr_choice
#echo $newusrpw_choice
#echo $duo_choice
#echo "You have decided: $docker_choice"

    # First Update all packages -y for no interactive

    echo "Configuring packages"
    echo "Removing SSH Root Login"
    sed -re 's/^(PermitRootLogin)([[:space:]]+)yes/\1\2no/' -i.`date -I` /etc/ssh/sshd_config
    # Configuring Chrony, way better than NTPd, much more reliable and stays in Sync.
    echo "Maybe add some time sources here"
    
if cat /etc/passwd | grep $newusr_choice >/dev/null; then
            echo "$newusr_choice exists!"
            exit 1
        else
            echo "root:$rootpw_choice" | chpasswd
            useradd $newusr_choice -s /bin/bash -m
            echo "$newusr_choice:$newusrpw_choice" | chpasswd
            usermod -aG sudo $newusr_choice
            [ $? -eq 0 ] && echo "User has been added to system.. oh and it's a sudo!" || echo "Failed to add a user!"
        fi

    hostnamectl set-hostname $hostname_choice
    #Need to edit /etc/hosts aswell 172.0.1.1 with hostname

    # Need to restart SSH for root password to take affect.
    service ssh restart
    
    if [ $docker_choice == "yes" ]; then
        echo "installing Docker"
        apt install apt-transport-https ca-certificates software-properties-common python-pip -y
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
        add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"
        apt update
        apt install docker-ce -y
        usermod -aG docker "$newusr_choice"
	pip install --upgrade pip
	pip install setuptools
	pip install docker-compose
    fi
    

    if [ $duo_choice == "yes" ]; then
        echo "installing Duo"
        echo 'deb http://pkg.duosecurity.com/Ubuntu xenial main' | tee /etc/apt/sources.list.d/duosecurity.list
		curl -s https://duo.com/APT-GPG-KEY-DUO | apt-key add -
		apt update -y
		apt install duo-unix
		sed -i '/ikey =/c\ikey = '"$duointegration"'' /etc/duo/pam_duo.conf
		sed -i '/skey =/c\skey = '"$duosecret"'' /etc/duo/pam_duo.conf
		sed -i '/host =/c\host = '"$duoAPIhostname"'' /etc/duo/pam_duo.conf
		sed -i '8 a\pushinfo = yes' /etc/duo/pam_duo.conf
		sed -i '9 a\autopush = yes' /etc/duo/pam_duo.conf
		sed -i '10 a\prompts = 1' /etc/duo/pam_duo.conf
		sed -re 's/^(ChallengeResponseAuthentication)([[:space:]]+)no/\1\2yes/' -i.`date -I` /etc/ssh/sshd_config
		sed -re 's/^(UsePAM)([[:space:]]+)no/\1\2yes/' -i.`date -I` /etc/ssh/sshd_config
		sed -i '88 a\UseDNS no' /etc/ssh/sshd_config
		sed -i '49 a\auth    required            /lib64/security/pam_duo.so' /etc/pam.d/sshd
		service ssh restart
    fi
