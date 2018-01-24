cancel_catch=0
exec 3>&1;
hostname_choice=$(dialog --inputbox "Enter the hostname for this server (e.g dedust2 .... don't use _)" 0 0 2>&1 1>&3);
    if [[ $? -eq 1 ]]; then
        #  cancel button pressed
        	cancel_catch=1
    elif [[ $? -eq 5 ]]; then
        #  timeout
        	cancel_catch=1
    fi
rootpw_choice=$(dialog --insecure --passwordbox "Change the root password" 0 0 2>&1 1>&3);
    if [[ $? -eq 1 ]]; then
        #  cancel button pressed
        	cancel_catch=1
    elif [[ $? -eq 5 ]]; then
        #  timeout
        	cancel_catch=1
    fi
rootpwconfirm_choice=$(dialog --insecure --passwordbox "Enter the password again" 0 0 2>&1 1>&3);
    if [[ $? -eq 1 ]]; then
        #  cancel button pressed
        	cancel_catch=1
    elif [[ $? -eq 5 ]]; then
        #  timeout
        	cancel_catch=1
    fi
newusr_choice=$(dialog --inputbox "Create your user (e.g Charlie)" 0 0 2>&1 1>&3);
    if [[ $? -eq 1 ]]; then
        #  cancel button pressed
        	cancel_catch=1
    elif [[ $? -eq 5 ]]; then
        #  timeout
        	cancel_catch=1
    fi
newusrpw_choice=$(dialog --insecure --passwordbox "Enter the password for $newusr_choice" 0 0 2>&1 1>&3);
    if [[ $? -eq 1 ]]; then
        #  cancel button pressed
        	cancel_catch=1
    elif [[ $? -eq 5 ]]; then
        #  timeout
        	cancel_catch=1
    fi
exitcode=$?;
exec 3>&-;
#echo $result $exitcode;

$(dialog --title "do you want this app" \
--backtitle "checking what apps you want to use" \
--yesno "Install Duo 2FA?" 0 0 2>&1 1>&3);

        if [[ $? -eq 0 ]] ; then
        echo "executing"
            duointegration=$(dialog --inputbox "Login to https://duo.com/
        Click Applications –> Protect an Application
        Scroll down to Unix Application and click Protect this Application
        We will need your integration key, secret key and API hostname.

        Copy and paste your integration key here:" 0 0 2>&1 1>&3);
        fi

dialog --title "do you want this app" \
--backtitle "checking what apps you want to use" \
--yesno "Install Docker?" 7 60

# Get exit status
# 0 means user hit [yes] button.
# 1 means user hit [no] button.
# 255 means user hit [Esc] key.
response=$?
case $response in
   0) docker_choice="yes";;
   1) docker_choice="no";;
   255) cancel_catch=1;;
esac



export cancel_catch=$cancel_catch
export testing="can't believe this works"
export hostname_choice=$hostname_choice
export rootpw_choice=$rootpw_choice
export rootpwconfirm_choice=$rootpwconfirm_choice
export newusr_choice=$newusr_choice
export newusrpw_choice=$newusrpw_choice
export docker_choice=$docker_choice
export duo_choice=$duo_choice