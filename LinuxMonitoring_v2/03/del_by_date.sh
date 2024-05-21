#!/bin/bash

start=$1
end=$2

reg_file=".*_[0-9][0-9][0-9][0-9][0-9][0-9]$"
date=$(date +'%d%m%y')
log_file="${date}.log"

free_root () {
  free=$(df --block-size=MB / | sed '1d')
  free=$(echo $free | cut -d ' ' -f 4)
  echo ${free}
}

# find /home/paha/1/ -type f -newermt "13 aug 2023 12:45" -not -newermt "13 aug 2023 12:55"
# find / -type f -regex '.*_[0-9]{6}$' -newerct "$start" -not -newerct "$end" &>>"$log_file"
# find / -type d -regex '.*_[0-9]{6}$' -newerct "$start" -not -newerct "$end" &>>"$log_file"

files=$(find / -type f -regex "$reg_file" -newerct "$start" -not -newerct "$end")
dirs=$(find / -type d -regex "$reg_file" -newerct "$start" -not -newerct "$end")

# echo "$files"
# echo "$dirs"

# c_files=$(echo "$files" | wc -l)
# c_dirs=$(echo "$dirs" | wc -l)
c_files=0
c_dirs=0

free=$(free_root)
echo "free / ${free}"

for name in $files; do
  let "c_files++"
  rm -rf "$name" &>/dev/null
  echo "${name} has been deleted" >> ${log_file}
done

for name in $dirs; do
  let "c_dirs++"
  rm -rf "$name" &>/dev/null
  echo "${name} has been deleted" >> ${log_file}
done

echo "${c_dirs} dirs has been deleted"
echo "${c_files} files has been deleted"

free=$(free_root)
echo "free / ${free}"

# find / -type f -newerBt "$start" -not -newerBt "$end" -delete &>>"$log_file"
# find / -type d -newerBt "$start" -not -newerBt "$end" -delete &>>"$log_file"
