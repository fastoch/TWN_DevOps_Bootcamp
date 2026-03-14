#!/bin/bash

while true
do
  echo "Enter 1 to sort by memory usage, 2 to sort by CPU usage, 0 to exit: "
  read choice
  
  # Regex validation: check if variable "choice" contains only digits (0-9)
  if [[ ! "$choice" =~ ^[0-9]+$ ]]; then
    echo "Invalid choice. Please enter 0, 1, or 2 only."
    continue
  fi
  
  # Now safe to use numeric comparison
  if [ "$choice" -eq 1 ]; then
    ps -u $USER --sort -rss -o user,pid,%cpu,%mem,comm
  elif [ "$choice" -eq 2 ]; then
    ps -u $USER --sort -%cpu -o user,pid,%cpu,%mem,comm
  elif [ "$choice" -eq 0 ]; then
    break
  else
    echo "Invalid choice. Please enter 0, 1, or 2 only."
  fi
done
