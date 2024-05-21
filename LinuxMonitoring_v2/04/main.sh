#!/bin/bash

. ./gen_agent
. ./gen_bytes
. ./gen_ip
. ./gen_method
. ./gen_response

next_time () {
  c_sec=$((5 + $RANDOM % 50))
  ((sec += c_sec))
  while ((sec > 59)); do
    ((sec -= 60))
    ((++minute))
    if ((minute > 59)); then
      ((minute -= 60))
      ((++hour))
    fi
  done
  # echo "[$day/$month/$year:$hour:$minute:$sec]"
  # printf "[%.2d/%s/%d:%.2d:%.2d:%.2d +0700]" $day $month $year $hour $minute $sec
}

mkdir -p logs

for ((u=0; u<5; u++)); do
  . ./new_date
  c_records=$((100 + $RANDOM % 900))
  for ((i=0; i<c_records; i++)); do
    next_time
    time=$(printf "[%.2d/%s/%d:%.2d:%.2d:%.2d +0700]" $day $month $year $hour $minute $sec)
    ip=$(gen_ip)
    method=$(gen_method)
    bytes=$(gen_bytes)
    response=$(gen_response)
    agent=$(gen_agent)
    record="${ip} - - ${time} ${method} ${response} ${bytes} \"-\" \"${agent}\""
    echo "$record" >> $log_file
  done

done