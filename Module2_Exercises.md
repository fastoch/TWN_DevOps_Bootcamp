# Nana's Solutions

https://gitlab.com/twn-devops-bootcamp/latest/02-linux/linux/-/blob/feature/solutions/Solutions.md

# Exercise 1 - create a Linux Mint VM

I've been using Linux since 2018.  
First running Ubuntu as my daily driver up until 2022.  
Then I switched to Arch Linux, and ran it until 2025.  
I'm now a happy Fedora user (KDE Plasma edition).  

---

# Exercise 2 - install Java

Here's my Bash script to install the latest java version and check successful installation:
```bash
#!/bin/bash

dnf upgrade -y
dnf install java -y

# using awk and head to return only the second field of the first line
java_version=$(java --version | awk '{print substr($2,1,2)}' | head -n 1)

if [ -z "$java_version" ]
then
  echo "Java installation failed, no java version found"
elif [ "$java_version" -lt 11 ]
then
  echo "Java version is lower than 11, you should upgrade to a newer version"
else 
  echo "Java has been successfully installed"
  echo "Java version is now $java_version"
fi
```

We can then run this script with `sudo ./install_java.sh`  
DO NOT forget to make the script executable before execution: `chmod +x install_java.sh`

## Detailed explanation 

The `awk` command `awk '{print substr($2,1,2)}'` extracts and prints the first two characters from 
the second field of each input line.  

`substr($2, 1, 2)` is AWK's built-in substring function:
- $2: The second field (word) on the line, split by default whitespace
- 1: Starting position 
- 2: Length of substring to extract

`print` outputs the result, one per line.  

After that, we pipe the result of awk into `head -n 1` to return only the first line.

---

# Exercise 3 - user processes

Create the script file: `vim user_processes.sh`  
Make it executable: `chmod +x user_processes.sh`

Script that displays the running processes for the current user:
```bash
#!/bin/bash

ps -u $USER -o user,pid,%cpu,%mem,cmd 
```
The `-o` option formats output for readability.  

We could run the following to count the number of processes running for the current user:
```bash
./user_processes.sh | wc -l
```

# Exercise 4 - user processes sorted

Ask user input for sorting the processes either by memory or CPU usage, and print the sorted list:
```bash
#!/bin/bash

echo "Would you like to sort the processes output by memory or CPU? (m/c) "
read sortby

if [ "$sortby" = "m" ]
then
  ps -u $USER --sort -rss -o user,pid,%cpu,%mem,comm 
elif [ "$sortby" = "c" ]
then
  ps -u $USER --sort -%cpu -o user,pid,%cpu,%mem,comm 
else
  echo "No valid input provided. Exiting"
fi
```

As usual, make the file executable: `chmod +x processes_sorted.sh`  
Then, run it: `./processes_sorted.sh`  

>[!tip]
>Run `./processes_sorted.sh | head -n 20` to print only the first 20 lines

# Exercise 5 - number of user processes sorted

Very similar to previous script but piping the output of `ps` commands into `head`:
```bash
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
```

- The `>&2` is used to prevent from displaying the error message to the user.  
- The use of double brackets in `$((results+1))` is for running arithmetic operations in bash
- We add 1 to the number of results because we need to include the header in our count

Make it executable: `chmod +x num_proc_sorted.sh`  
Run it: `./num_proc_sorted.sh`

## Regex usage explanation

- The double square brackets `[[ ]]` and `=~` operator are used for regular expression pattern matching
- `^[0-9]+$`: means "match anything that starts with a digit and is followed by any number of digits"
  - `+` is a "quantifier" that matches one or more occurrences of the preceding character
  - `^` is an "anchor" character that matches the beginning of the string
  - `$` is an "anchor" character that matches the end of the string

## Improved version of exercice 5 script

Our script can be improved with input validation loops to keep prompting until valid inputs are received.  

Here's a refactored version:
```bash
#!/bin/bash

# Function to get valid sorting criteria (m/c) with loop
get_sort_criteria() {
  while true; do
    echo "Would you like to sort the processes output by memory or CPU? (m/c): "
    read sortby
    case "$sortby" in
      [mM]) sortby="m"; echo "Sorting by memory."; return 0 ;;
      [cC]) sortby="c"; echo "Sorting by CPU."; return 0 ;;
      *) echo "Invalid input. Please enter 'm' for memory or 'c' for CPU." >&2 ;;
    esac
  done
}

# Function to get valid number of results with loop
get_num_results() {
  while true; do
    echo "How many results do you want to display? "
    read results
    if [[ "$results" =~ ^[0-9]+$ ]] && [ "$results" -gt 0 ]; then
      return 0
    else
      echo "Invalid number. Please enter a positive integer." >&2
    fi
  done
}

# Main execution
get_sort_criteria
get_num_results

# At this point, sortby is GUARANTEED to be "m" OR "c"
if [ "$sortby" = "m" ]; then
  ps -u "$USER" --sort -rss -o user,pid,%cpu,%mem,comm | head -n $((results + 1))
else
  ps -u "$USER" --sort -%cpu -o user,pid,%cpu,%mem,comm | head -n $((results + 1))
fi
```

Run as `./num_proc_sorted_improved.sh`.  
It will loop indefinitely on invalid input while providing clear feedback.  
For production, add a max attempt counter (e.g., break after 5 tries).

## Explanation of improved version

- The `return 0` on valid input is used to break out of the loop
- The `while true; do ... done` loop is used to keep prompting until valid input is received
- we use a double condition in the `get_num_results` function to make sure the number of results is positive 

# Exercise 6 - start Node App

**Context**:  
We have a ready NodeJS application that needs to run on a server.  
The app is already configured to read in environment variables.  

To run the following script: `sudo ./start_node_app.sh`  

```bash
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
node server.js
```