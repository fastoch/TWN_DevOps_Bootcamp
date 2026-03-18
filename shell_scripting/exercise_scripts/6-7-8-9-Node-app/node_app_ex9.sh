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

# create dedicated service user if it doesn't exist
SERVICE_USER="nodeapp"
if ! id "$SERVICE_USER" &> /dev/null; then
  echo "Creating dedicated service user: $SERVICE_USER"
  useradd -r -s /bin/false -d /opt/nodeapp -m "$SERVICE_USER"
else
  echo "Service user $SERVICE_USER already exists"
fi

# Set the app directory and ensure owner is the service user
APP_DIR="/opt/nodeapp"
mkdir -p "$APP_DIR"
chown -R "$SERVICE_USER":"$SERVICE_USER" "$APP_DIR"
echo ""

# read user input for log directory (before starting the app)
echo "Enter the log directory location (absolute path): "
read LOG_DIRECTORY

# check if log directory exists and is a directory
if [ -d "$LOG_DIRECTORY" ]; then
  echo "$LOG_DIRECTORY already exists"
else
  mkdir -p $LOG_DIRECTORY
  echo "A new directory $LOG_DIRECTORY has been created"
fi

echo ""

# Change the download/extract target to $APP_DIR
cd $APP_DIR
curl -O https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz
tar -xvzf bootcamp-node-envvars-project-1.0.0.tgz

# change the working directory to the folder where the app archive was extracted
cd package

# set needed environment variables
export APP_ENV=dev
export DB_USER=myuser
export DB_PWD=mysecret
export LOG_DIR=$LOG_DIRECTORY

# install dependencies as service user
sudo -u "$SERVICE_USER" npm install
echo ""

# kill any existing node app processes
pid=$(ps aux | grep "node server" | grep "$SERVICE_USER" | grep -v grep | awk '{print $2}')
[ n "$pid" ] && echo "Node app is already running. Killing process $pid" && kill $pid
echo ""

# start the node.js app in the background as service user
sudo -u "$SERVICE_USER" node server.js &

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
