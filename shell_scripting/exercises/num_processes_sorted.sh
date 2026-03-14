#!/bin/bash

echo "Would you like to sort the processes output by memory or CPU? (m/c) "
read sortby

if [ "$sortby" = "m" ]
then
  echo "How many results do you want to display? "
  read lines
  ps -u $USER --sort -rss -o user,pid,%cpu,%mem,comm | head -n "$lines"
elif [ "$sortby" = "c" ]
then
  echo "How many results do you want to display? "
  read lines
  ps -u $USER --sort -%cpu -o user,pid,%cpu,%mem,comm | head -n "$lines"
else
  echo "No valid input provided. Exiting"
fi
