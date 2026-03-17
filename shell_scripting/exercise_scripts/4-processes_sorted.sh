#!/bin/bash

echo "Would you like to sort the processes output by memory or CPU? (m/c) "
read sortby

if [ "$sortby" = "m" ]
then
  ps -u $USER --sort -rss -o user,pid,%cpu,%mem,comm 
elif [ "$sortby" = "c" ]
then
  ps -u $USER --sort -%cpu -o user,pid,%cpu,%mem,comm 
else
  echo "No valid input provided. Exiting"
fi
