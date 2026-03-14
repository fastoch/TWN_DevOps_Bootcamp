# Nana's Solutions

https://gitlab.com/twn-devops-bootcamp/latest/02-linux/linux/-/blob/feature/solutions/Solutions.md

# Exercise 1

I've been using Linux since 2018.  
First running Ubuntu as my daily driver up until 2022.  
Then I switched to Arch Linux, and ran it until 2025.  
I'm now a happy Fedora user (KDE Plasma edition).  

---

# Exercise 2

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
  echo "Java version is $java_version"
fi
```

We can then run this script with `sudo ./install_java.sh`  
DO NOT forget to make the script executable before running: `chmod u+x install_java.sh`

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

# Exercise 3

