cancel_catch=0
exec 3>&1;
hostname_choice=$(dialog --inputbox "Enter your hostname (e.g dedust2)" 0 0 2>&1 1>&3);
if test $? -eq 1
then 
	cancel_choice=1
fi
rootpw_choice=$(dialog --inputbox "Change the root password" 0 0 2>&1 1>&3);
newusr_choice=$(dialog --inputbox "Create your user (e.g Charlie)" 0 0 2>&1 1>&3);
newusrpw_choice=$(dialog --insecure --passwordbox "Enter the password for $newusr_choice" 0 0 2>&1 1>&3);
exitcode=$?;
exec 3>&-;
#echo $result $exitcode;

dialog --title "do you want this app" \
--backtitle "checking what apps you want to use" \
--yesno "do you want docker" 7 60

# Get exit status
# 0 means user hit [yes] button.
# 1 means user hit [no] button.
# 255 means user hit [Esc] key.
response=$?
case $response in
   0) docker_choice="yes";;
   1) docker_choice="no";;
   255) docker_choice="ESC KEY PRESSED ABORT THE MISSION";;
esac

if [[ $docker_choice == "yes" ]]
    then
        echo "installing Docker"
fi

export cancel_catch=$cancel_catch
export testing="can't believe this works"
export hostname_choice=$hostname_choice
export rootpw_choice=$rootpw_choice
export newusr_choice=$newusr_choice
export newusrpw_choice=$newusrpw_choice
export docker_choice=$docker_choice