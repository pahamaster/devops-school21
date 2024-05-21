#!/bin/bash

# "asdf_123456"
# "^[asdf]_123456$"
# find . -regex ".*/[a]+[s]+[d]+[f]+_123456$"

mask=$1

free_root () {
  free=$(df --block-size=MB / | sed '1d')
  free=$(echo $free | cut -d ' ' -f 4)
  echo ${free}
}

c_files=0
c_dirs=0

free=$(free_root)
echo "free / ${free}"

len=${#mask}
date=$(date +'%d%m%y')
log_file="${date}.log"

reg_file=".*/"
for ((i=0; i<len; i++)); do
  c="${mask:${i}:1}"
  if [[ $c == "_" ]]; then
    reg_file="${reg_file}${mask:${i}}"
    break
  else
    reg_file="${reg_file}[${mask:${i}:1}]+[.]?"
  fi
done

# echo $reg_file

# find / -regex "$reg_file" -delete &>>"$log_file"

files=$(find / -regex "$reg_file" 2>>/dev/null)

# echo "$files"

for name in $files; do
  # echo "$name"
  if [[ -f "$name" ]]; then
    let "c_files += 1"
    rm -rf "$name" &>/dev/null
    echo "${name} has been deleted" >> ${log_file}
  fi
done

for name in $files; do
  # echo "$name"
  if [[ -d "$name" ]]; then
    let "c_dirs += 1"
    rm -rf "$name" &>/dev/null
    echo "${name} has been deleted" >> ${log_file}
  fi
done

echo "${c_dirs} dirs has been deleted"
echo "${c_files} files has been deleted"

free=$(free_root)
echo "free / ${free}"
