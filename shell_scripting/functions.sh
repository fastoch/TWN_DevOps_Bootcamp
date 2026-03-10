#!/bin/bash

function print_info {
  echo "name: $1"
  echo "age: $2"
  echo "email: $3"
}

print_info "John Doe" "30" "2Wf5t@example.com"

function sum() {
  read -p "Enter first number: " num1
  read -p "Enter second number: " num2
  echo "The sum of $num1 and $num2 is $(($num1+$num2))"
}

sum
