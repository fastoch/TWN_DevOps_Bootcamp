#!/bin/bash

echo "Would you like to sort the processes output by memory or CPU? (m/c) "
read sortby

function sort_results() {
  if [ "$sortby" = "m" ]
  then
    ps -u $USER --sort -rss -o user,pid,%cpu,%mem,comm 
  elif [ "$sortby" = "c" ]
  then
    ps -u $USER --sort -%cpu -o user,pid,%cpu,%mem,comm 
  else
    echo "No valid input provided. Exiting"
  fi
}

function num_results() {
  # check if sortby value is valid before asking for number of results
  if [ ! "$sortby" = "m" ] && [ ! "$sortby" = "c" ]
  then
    echo "No valid input provided"
    return
  fi

	echo "How many results do you want to display? "
  read results
  if [[ ! "$results" =~ ^[0-9]+$ ]] || [ "$results" -eq 0 ]
  then
    echo "Invalid number of results" >&2
  else
    sort_results | head -n $((results+1))
  fi
}

num_results
