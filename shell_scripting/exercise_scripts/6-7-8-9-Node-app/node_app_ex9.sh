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
SERVICE_USER="myapp"
if ! id "$SERVICE_USER" &> /dev/null; then
  echo "Creating dedicated service user: $SERVICE_USER"
  useradd $SERVICE_USER -m
  echo "$SERVICE_USER created"
else
  echo "Service user $SERVICE_USER already exists"
fi
echo ""

# read user input for log directory (before starting the app)
echo "Enter the log directory location (absolute path): "
read LOG_DIRECTORY

# check if log directory exists and creates it if not
if [ -d "$LOG_DIRECTORY" ]; then
  echo "$LOG_DIRECTORY already exists"
else
  # create log directory 
  mkdir -p "$LOG_DIRECTORY"
  echo "A new directory $LOG_DIRECTORY has been created"
fi

# make service user owner of log directory 
chown -R "$SERVICE_USER:$SERVICE_USER" "$LOG_DIRECTORY"
echo ""

# Kill existing app process if running
pid=$(ps aux | grep "node server" | grep -v grep | awk '{print $2}')
if [ -n "$pid" ]; then
  echo "Node app is already running. Killing process $pid"
  kill $pid
fi

echo ""

# executing the following commands as new user using 'runuser' command

# fetch NodeJS project archive from s3 bucket
runuser -l $NEW_USER -c "wget https://node-envvars-artifact.s3.eu-west-2.amazonaws.com/bootcamp-node-envvars-project-1.0.0.tgz"

# extract the project archive to ./package folder
runuser -l $NEW_USER -c "tar zxvf ./bootcamp-node-envvars-project-1.0.0.tgz"

# start the nodejs application in the background, with all needed env vars with new user myapp
runuser -l $NEW_USER -c "
    export APP_ENV=dev && 
    export DB_PWD=mysecret && 
    export DB_USER=myuser && 
    export LOG_DIR=$LOG_DIRECTORY && 
    cd package && 
    npm install && 
    node server.js &"

# wait 4 secondes for the app to be up and running
sleep 4

# check app status and process ID
echo "Node app status and PID:"
ps aux | head -n 1 && ps aux | grep "node server" | grep -v grep | grep -v npm
echo ""

# get the app's listening port
echo -n "Node App is listening on port "
pid=$(ps aux | grep "node server" | grep -v grep | grep -v npm | awk '{print $2}')
ss -lntp | grep "$pid" | awk '{print substr($4,3,5)}'
