#!/bin/bash

# Update packages
echo "updating packages"
dnf upgrade -y

# Install NodeJS and NPM and print out which versions were installed
echo "installing node & npm"
dnf install nodejs -y
dnf install npm -y

echo "NodeJS version installed: $(node -v)"
echo "NPM version installed: $(npm -v)"

# installing other required tools
echo "installing curl, wget, net-tools"
dnf install curl -y
dnf install wget -y
dnf install net-tools -y

# download artifact file
curl -O https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz

# extract downloaded file
tar -xvzf bootcamp-node-envvars-project-1.0.0.tgz

# set needed environment variables
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret

cd package

# install dependencies
npm install

# check if app is already running and kill process if it is
pid=$(ps aux | grep "node server" | grep -v grep | awk '{print $2}')
if [ -n "$pid" ]; then
  echo "Node app is already running. Killing process $pid"
  kill $pid
fi

# start the node.js app in the background
node server.js &

# wait 4 secondes for the app to be up and running
sleep 4

# check app status and process ID
echo "Node app status and PID:"
ps aux | head -n 1 && ps aux | grep "node server" | grep -v grep

# get the app's listening port
echo -n "Node App is listening on port: "
pid=$(ps aux | grep "node server" | grep -v grep | awk '{print $2}')
ss -lntp | grep "$pid" | awk '{print substr($4,3,5)}'

