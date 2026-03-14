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
DO NOT forget to make the script executable before running: `chmod +x install_java.sh`

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

Script that displays the running processes for the current user:
```bash
#!/bin/bash

ps -u $USER -o user,pid,%cpu,%mem,cmd 
```
The `-o` option formats output for readability.  

We could run the following to count the number of processes running for the current user:
```bash
ps -u $USER -o user,pid,%cpu,%mem,cmd | wc -l
```

# Exercise 4 - user processes sorted

Ask for user input for sorting the processes either by memory or CPU consumption, and print the sorted list.  
```bash
#!/bin/bash

while true
do
  echo "Enter 1 to sort by memory usage, 2 to sort by CPU usage, 0 to exit: "
  read choice
  
  # Regex validation: check if variable "choice" contains only digits (0-9)
  if [[ ! "$choice" =~ ^[0-9]+$ ]]; then
    echo "Invalid choice. Please enter 0, 1, or 2 only."
    continue
  fi
  
  # Now safe to use numeric comparison
  if [ "$choice" -eq 1 ]; then
    ps -u $USER --sort -rss -o user,pid,%cpu,%mem,comm
  elif [ "$choice" -eq 2 ]; then
    ps -u $USER --sort -%cpu -o user,pid,%cpu,%mem,comm
  elif [ "$choice" -eq 0 ]; then
    break
  else
    echo "Invalid choice. Please enter 0, 1, or 2 only."
  fi
done
```

As usual, make the file executable: `chmod +x sort_processes.sh`  
Then, run it: `./sort_processes.sh`  

>[!tip]
>Run `./sort_processes.sh | head -n 20` to print only the first 20 lines

## Explanation

- The `while true` loop prevents from exiting the program on invalid user input
- Always quote variables ("$choice") to handle spaces/empty input safely
- The double square brackets `[[ ]]` are required for regex validation
- The regex match operator `=~` checks if user input matches a regular expression
- Regex pattern breakdown:
  - `^` = start of string (anchor)
  - `[0-9]` = any digit from 0 to 9
  - `+` = one or more occurrences  
  - `$` = end of string (anchor) 
- `continue` skips to next loop iteration without showing duplicate error
- `comm` gives the truncated executable name of the process  
- `pid` is the process ID  

# Exercise 5 - number of user processes sorted

Very similar to previous script but piping the output of `ps` commands into `head -n "$lines"`:
```bash
#!/bin/bash

while true
do
  echo "Enter 1 to sort by memory usage, 2 to sort by CPU usage, 0 to exit: "
  read choice

  echo "Enter the number of processes to display: "
  read lines
  
  # Regex validation: check if variable "choice" contains only digits (0-9)
  if [[ ! "$choice" =~ ^[0-9]+$ ]]; then
    echo "Invalid choice. Please enter 0, 1, or 2 only."
    continue
  fi

  # Regex validation: check if variable "lines" contains only digits 
  if [[ ! "$lines" =~ ^[0-9]+$ ]]; then
    echo "Invalid number of processes. Please enter a number only."
    continue
  fi
  
  # Now safe to use numeric comparison
  if [ "$choice" -eq 1 ]; then
    ps -u $USER --sort -rss -o user,pid,%cpu,%mem,comm | head -n "$lines"
  elif [ "$choice" -eq 2 ]; then
    ps -u $USER --sort -%cpu -o user,pid,%cpu,%mem,comm | head -n "$lines"
  elif [ "$choice" -eq 0 ]; then
    break
  else
    echo "Invalid choice. Please enter 0, 1, or 2 only."
  fi
done
```