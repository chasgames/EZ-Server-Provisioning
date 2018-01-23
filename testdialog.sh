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

export docker_choice