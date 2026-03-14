#!/bin/bash

function print_info() {
  echo "name: $1"
  echo "age: $2"
  echo "email: $3"
}

print_info "John Doe" "30" "2Wf5t@example.com"

function sum() {
  echo "Let's add two numbers:"
	read -p "Enter first number: " num1
  read -p "Enter second number: " num2
  echo "The sum of $num1 and $num2 is $(($num1+$num2))"
}

sum

function multiply() {
	echo "Let's multiply two numbers:"  
	read -p "Enter first number: " num1
  read -p "Enter second number: " num2
  result=$(($num1*$num2))
  return $result 
  # following line does not display the result, it just returns it
  return $result 
  # following line will never be executed since it is after the `return` instruction
  echo "The result is $result"
}

# invoking the function
multiply
# using the return value with $?
echo "The result is $?"
