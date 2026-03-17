#!/bin/bash

echo "set up and configure my server"
echo

file_name=config.yaml
command_output=$(cat /etc/os-release)

echo "using file $file_name to configure something"
echo
echo "OS information:"
echo "$command_output"
echo

config_dir=$1

if [ -d "$config_dir" ] 
then
  echo "reading config directory contents..."
  echo "Here are the config files:"
  ls "$config_dir"
else 
  echo "config directory not found, creating one..."
  mkdir ~/config
fi
