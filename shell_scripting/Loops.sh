#!/bin/bash

echo "all arguments: $*"
echo "number of arguments: $#"

for arg in $*
	do
		if [ -d "$arg" ]
		then		
			echo "$arg is a directory"
		else
			echo "$arg is not a directory or is not located in the current folder"
		fi
	done
	
