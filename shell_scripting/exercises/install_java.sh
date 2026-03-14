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
