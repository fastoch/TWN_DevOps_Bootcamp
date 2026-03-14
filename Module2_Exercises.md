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

Create the script file: `vim processes.sh`  
Make it executable: `chmod +x processes.sh`

Script that displays the running processes for the current user:
```bash
#!/bin/bash

ps -u $USER -o user,pid,%cpu,%mem,cmd 
```
The `-o` option formats output for readability.  

We could run the following to count the number of processes running for the current user:
```bash
./processes.sh | wc -l
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
>Run `./sort_processes.sh | head -n 20` to print only the first 20 lines

# Exercise 5 - number of user processes sorted

Similar to previous script but piping the output of `ps` commands into `head -n "$lines"`:
```bash
#!/bin/bash

echo "Would you like to sort the processes output by memory or CPU? (m/c) "
read sortby

if [ "$sortby" = "m" ]
then
  echo "How many results do you want to display? "
  read lines
  ps -u $USER --sort -rss -o user,pid,%cpu,%mem,comm | head -n "$lines"
elif [ "$sortby" = "c" ]
then
  echo "How many results do you want to display? "
  read lines
  ps -u $USER --sort -%cpu -o user,pid,%cpu,%mem,comm | head -n "$lines"
else
  echo "No valid input provided. Exiting"
fi
```

# Exercise 6 - start Node App

**Context**:  
We have a ready NodeJS application that needs to run on a server.  
The app is already configured to read in environment variables.  