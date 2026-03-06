#!/bin/bash

echo "set up and configure my server"

file_name=config.yaml
command_output=$(cat /etc/os-release)

echo "using file $file_name to configure something"
echo "OS information:"
echo "$command_output"
