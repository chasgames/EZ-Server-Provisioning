 exec 3>&1;
      1 result=$(dialog --inputbox test 0 0 2>&1 1>&3);
      2 exitcode=$?;
      3 exec 3>&-;
      4 echo $result $exitcode;
