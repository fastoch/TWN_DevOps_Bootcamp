#!/bin/bash

# Update packages
echo "updating packages"
dnf upgrade -y
echo ""

# Install NodeJS and NPM and print out which versions were installed
echo "installing node & npm, curl, wget and net-tools"
dnf install -y nodejs npm curl wget net-tools

# wait 5 seconds for the packages to be installed
sleep 5
echo ""

echo "NodeJS version installed: $(node -v)"
echo "NPM version installed: $(npm -v)"
echo ""

# read user input for log directory (before starting the app)
echo "Enter the log directory location (absolute path): "
read LOG_DIRECTORY

# check if log directory exists and is a directory
if [ -d "$LOG_DIRECTORY" ]; then
  echo "$LOG_DIRECTORY already exists"
  export LOG_DIR=$LOG_DIRECTORY
else
  mkdir -p $LOG_DIRECTORY
  echo "A new directory $LOG_DIRECTORY has been created"
  export LOG_DIR=$LOG_DIRECTORY
fi

echo ""

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
echo ""

# check if app is already running and kill the process if it is
pid=$(ps aux | grep "node server" | grep -v grep | awk '{print $2}')
if [ -n "$pid" ]; then
  echo "Node app is already running. Killing process $pid"
  kill $pid
fi

echo ""

# start the node.js app in the background
node server.js &

# wait 4 secondes for the app to be up and running
sleep 4

# check app status and process ID
echo "Node app status and PID:"
ps aux | head -n 1 && ps aux | grep "node server" | grep -v grep
echo ""

# get the app's listening port
echo -n "Node App is listening on port "
pid=$(ps aux | grep "node server" | grep -v grep | awk '{print $2}')
ss -lntp | grep "$pid" | awk '{print substr($4,3,5)}'
