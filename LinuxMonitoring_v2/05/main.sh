#!/bin/bash

method=$1

logs=$(cat ../04/logs/*.log)

if [[ $method == 1 ]]; then
  echo "$logs" | sort -nk 9
elif [[ $method == 2 ]]; then
  echo "$logs" | awk '{print $1}' | sort -u
elif [[ $method == 3 ]]; then
  echo "$logs" | awk '{
    if (match($9, /^[4,5]/) != 0) {
      print $0
    }
  }'
elif [[ $method == 4 ]]; then
  echo "$logs" | awk '{
    if (match($9, /^[4,5]/) != 0) {
      print $1
    }
  }' | sort -u
else
  echo "Error: The 1st argument must be from 1 to 4"
fi

#log_file=$2

# awk '{print $9}' $log_file | sort | uniq -c | sort -rn

# if [[ ! -f ${log_file} ]]; then
#   echo "Error: The 2nd argument mmust be a correct log file of nginx"
# else
#   if [[ $method == 1 ]]; then
#     sort -nk 9 $log_file
#   elif [[ $method == 2 ]]; then
#     awk '{print $1}' $log_file | sort -u
#   elif [[ $method == 3 ]]; then
#     awk '{
#       if (match($9, /^[4,5]/) != 0) {
#         print $0
#       }
#     }' $log_file
#   elif [[ $method == 4 ]]; then
#     awk '{
#       if (match($9, /^[4,5]/) != 0) {
#         print $1
#       }
#     }' $log_file | sort -u
#   else
#     echo "Error: The 1st argument must be from 1 to 4"
#   fi
# fi