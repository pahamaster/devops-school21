#!/bin/bash

count_dirs () {
  local count=0
  for elem in $1*;do
    if [ -d "$elem" ]; then
      let "count++"
      let "count += $(count_dirs "$elem/")"
    fi
  done
  echo "$count"
}

#echo "$(cd "$dirname "$1")"; pwd)/$(basename "$1")"
#echo "$(pwd)/$line"

count_dirs $1

