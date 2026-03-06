#!/bin/bash

echo "set up and configure my server"

file_name=config.yaml
command_output=$(cat /etc/os-release)

echo "using file $file_name to configure something"
echo "OS information:"
echo "$command_output"

if [ -d ~/config ] 
then
  echo "reading config directory contents"
  config_files=$(ls ~/config)
  echo "Here are the config files:"
  echo "$config_files"
else 
  echo "config directory not found, creating one"
  mkdir ~/config
fi
