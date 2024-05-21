#!/bin/bash

dir=$1
count_files=$2
sym_file=$3
date=$4
size_file=$5

log_file="${date}.log"
log_file_dirs="${date}_dirs.log"

add_sym () {
  str=$1
  len=${#str}
  i=$(($RANDOM % ${len}));
  while [[ ${str:${i}:1} == '.' ]]; do
    i=$(($RANDOM % ${len}));
  done

  res="${str:0:${i}+1}${str:${i}}"
  echo ${res}
}

free_root () {
  # free=$(df --block-size=MB / | cut -d ' ' -f 4 | sed 's/MB//')
  # free=$(df --block-size=MB / | grep -E "\s/$")
  free=$(df --block-size=MB / | sed '1d')
  free=$(echo $free | cut -d ' ' -f 4 | sed 's/MB//')
  echo ${free}
}

while IFS= read -r line; do
  # echo "$line"
  name=${sym_file}
  for ((u=0; u<count_files; u++)); do
    name=$(add_sym $name)
    full_name="${line}/${name}_${date}"
    # while [[ -e ${full_name} || ${#name} < 5 ]]; do
    while [ ${#name} -lt 5 ]; do
      name=$(add_sym $name)
      full_name="${line}/${name}_${date}"
    done
    # touch ${full_name}
    # dd if=/dev/zero of=${full_name} bs=${size_file} count=1
    date_time=$(date +'%d.%m.%y_%H:%M:%S')
    fallocate -l ${size_file} ${full_name}
    echo "${full_name} ${date_time} ${size_file}" >> ${log_file}
    free=$(free_root)
    # echo "$free"
    if [[ $free -le 1000 ]]; then
      exit 1
    fi
  done
done < "${log_file_dirs}"