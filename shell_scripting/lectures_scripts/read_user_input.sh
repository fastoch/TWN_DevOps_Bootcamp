#!/bin/bash

echo "all params: $*"
echo "number of params: $#"
echo "Reading user input"
read -p "Please enter your password: " user_pwd
echo "Your new password \"$user_pwd\" has been set"
