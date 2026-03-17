let express = require('express');
let path = require('path');
let fs = require('fs');
var util = require('util');
let app = express();

// read required env vars
const appEnv = process.env.APP_ENV
const dbUser = process.env.DB_USER
const dbPwd = process.env.DB_PWD

// read optional env var
const logDir = process.env.LOG_DIR

function displayResponse() {
  if (appEnv && dbUser && dbPwd) {
    console.log("-----------------------------")
    console.log("successfully set the following environment variables: ")
    console.log("APP_ENV -", appEnv)
    console.log("DB_USER -", dbUser)
    console.log("DB_PWD -", dbPwd)
    console.log("-----------------------------")
  }
  else {
    console.error("One of the expected environment variables is not set")
    console.log("exiting the application")
    process.exit(1)
  }

  if (logDir) {
    var log_file = fs.createWriteStream(logDir + '/app.log', {flags : 'w'});
    var log_stdout = process.stdout;

    console.log = function(d) {
      log_file.write(util.format(d) + '\n');
      log_stdout.write(util.format(d) + '\n');
    };

    console.log(`successfully set LOG_DIR environment variable. Writing logs into ${logDir}`)
    console.log("-----------------------------")
    console.log("Logging into the app.log file")
    console.log("Application started successfully using all the provided environment variables")
    console.log("Node app will listen for any incoming connections")
    console.log("This is the end of log entries")
    console.log("-----------------------------")
  }
  else {
    console.warn("Optional LOG_DIR environment variable not set")
  }
}

app.listen(3000, function () {
  console.log("app listening on port 3000!");
  displayResponse()
});

