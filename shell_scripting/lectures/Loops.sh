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

echo ""

balance=100
echo "your current balance is $balance$" 
echo "enter \"quit\" to exit the program"

while (( balance > 0 ))
  do
		read -p "enter a cost: " cost
		if [ "$cost" == "quit" ]
		then
			break
		fi
		(( balance-=cost ))
		echo "your balance is now $balance$"
  done	

if [ "$balance" -le 0 ]
then
	echo "You don't have any money left"
fi
