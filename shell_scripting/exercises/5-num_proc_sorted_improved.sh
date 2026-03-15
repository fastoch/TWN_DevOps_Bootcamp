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
