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

c_dirs=$(count_dirs $1)
echo "Total number of folders (including all nested ones) = $c_dirs"


#top_5_folders=$(du -h -d 1 "$1" | sort -rh | sed '1d' | sed '6,$d')
top_5_folders=$(du -h "$1" | sort -rh | sed '1d' | sed '6,$d')
echo "TOP 5 folders of maximum size arranged in descending order (path and size):"
if [[ c_dirs -ne 0 ]]; then
 #echo "$top_5_folders" | awk '{print FNR" - "$2", "$1}'
 echo "$top_5_folders" | awk -f top5dirs.awk
fi

