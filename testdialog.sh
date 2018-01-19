 exec 3>&1;
<<<<<<< HEAD
      1 result=$(dialog --inputbox test 0 0 2>&1 1>&3);
      2 exitcode=$?;
      3 exec 3>&-;
      4 echo $result $exitcode;

dialog --title "Delete file" \
--backtitle "Linux Shell Script Tutorial Example" \
--yesno "Are you sure you want to permanently delete \"/tmp/foo.txt\"?" 7 60

# Get exit status
# 0 means user hit [yes] button.
# 1 means user hit [no] button.
# 255 means user hit [Esc] key.
response=$?
case $response in
   0) echo "File deleted.";;
   1) echo "File not deleted.";;
   255) echo "[ESC] key pressed.";;
esac
=======
 result=$(dialog --inputbox test 0 0 2>&1 1>&3);
 exitcode=$?;
 exec 3>&-;
 echo $result $exitcode;
>>>>>>> 38ba8b6517bc2db27e656b0ab323e0057fd2151c
