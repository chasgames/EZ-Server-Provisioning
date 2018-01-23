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

exec 3>&1;
result=$(dialog --inputbox test 0 0 2>&1 1>&3);
exitcode=$?;
exec 3>&-;
echo $result $exitcode;

choiceone="the result is $result"
export testing="can't believe this works"
export docker_choice=$docker_choice
export response
export choiceone
