#!/bin/bash

sym_dir=$1
sym_file=$2
size_file=$3
date=$4

. ./fn.sh

reg_ns=".* .*"
# reg_no_bin="^.*bin.*$|^.*sbin.*$"

log_file="${date}.log"

name=$sym_dir

d_time_start=$(date +'%d.%m.%y_%H:%M:%S')
uptime=$(</proc/uptime)
time_begin=${uptime%% *}
# echo "time_begin $time_begin"

dirs=$(find / -type d -not -path "*/bin/*" -not -path "*/bin" -not -path "*/sbin/*" -not -path "*/sbin" 2>/dev/null)

count_dirs=$(echo "$dirs" | wc -l)
# echo $count_dirs

free=$(free_root_mb)
echo "free= $free"

c_dirs=0
c_files=0

exit=0

# for ((i=0; i<100 && exit==0; i++)); do
#   dir_new=$sym_dir
#   n_dir=$((1 + $RANDOM % ${count_dirs}))
#   dir_random=$(echo "$dirs" | sed -n "${n_dir}p")
#   while [[ "$dir_random" =~ $reg_ns ]]; do
#     # echo "Spaces: $dir_random"
#     n_dir=$((1 + $RANDOM % ${count_dirs}))
#     dir_random=$(echo "$dirs" | sed -n "${n_dir}p")
#   done
#   # echo "$dir"
#   full_dir="${dir_random}/${dir_new}_${date}"
#   while [[ -e ${full_dir} || ${#dir_new} < 5 ]] ; do
#     dir_new=$(add_sym "$dir_new")
#     full_dir="${dir_random}/${dir_new}_${date}"
#   done
#   # echo $full_dir
#   mkdir "${full_dir}" &>/dev/null
#   let "c_dirs += 1"
#   date_time=$(date +'%d.%m.%y_%H:%M:%S')
#   echo "${full_dir} ${date_time}" >> ${log_file}
#   count_files=$((1 + $RANDOM % 70))
#   let "c_files += count_files"
#   file_new=$sym_file
#   full_name="${full_dir}/${file_new}_${date}"
#   for ((u=0; u<$count_files && exit==0; u++)); do
#     while [[ -e ${full_name} || ${#file_new} -lt 6 ]]; do
#       file_new=$(add_sym $file_new)
#       full_name="${full_dir}/${file_new}_${date}"
#     done
#     # echo "${full_name} ${size_file}"
#     fallocate -l "${size_file}" "${full_name}" &>/dev/null
#     echo "${full_name} ${date_time} ${size_file}" >> ${log_file}
#     free=$(free_root_mb)
#     # echo "$free"
#     # if [[ $free == "1,0G" || $free == "1.0G" ]]; then
#     #   exit=1
#     # fi
#     free=$(echo "$free" | sed 's/MB//')
#     if (( $free <= 1000 )); then
#       exit=1
#     fi
#   done
# done

while ((exit==0)); do
  n_dir=$((1 + $RANDOM % ${count_dirs}))
  dir_random=$(echo "$dirs" | sed -n "${n_dir}p")
  while [[ "$dir_random" =~ $reg_ns ]]; do
    # echo "Spaces: $dir_random"
    n_dir=$((1 + $RANDOM % ${count_dirs}))
    dir_random=$(echo "$dirs" | sed -n "${n_dir}p")
  done
  # echo "$dir"
  dir_new=$sym_dir
  while [[ ${#dir_new} -lt 5 ]] ; do
    dir_new=$(add_sym "$dir_new")
  done
  full_dir="${dir_random}/${dir_new}_${date}"
  for ((i=0; i<100 && exit==0; i++)); do
    while [[ -e ${full_dir} ]] ; do
      dir_new=$(add_sym "$dir_new")
      full_dir="${dir_random}/${dir_new}_${date}"
    done
    # echo $full_dir
    mkdir "${full_dir}" &>/dev/null
    let "c_dirs += 1"
    date_time=$(date +'%d.%m.%y_%H:%M:%S')
    echo "${full_dir} ${date_time}" >> ${log_file}
    count_files=$((1 + $RANDOM % 30))
    let "c_files += count_files"
    file_new=$sym_file
    while [[ ${#file_new} -lt 6 ]]; do
      file_new=$(add_sym $file_new)
    done
    full_name="${full_dir}/${file_new}_${date}"
    for ((u=0; u<$count_files && exit==0; u++)); do
      while [[ -e ${full_name} ]]; do
        file_new=$(add_sym $file_new)
        full_name="${full_dir}/${file_new}_${date}"
      done
      # echo "${full_name} ${size_file}"
      fallocate -l "${size_file}" "${full_name}" &>/dev/null
      echo "${full_name} ${date_time} ${size_file}" >> ${log_file}
      free=$(free_root_mb)
      free=$(echo "$free" | sed 's/MB//')
      if (( $free <= 1000 )); then
        exit=1
      fi
    done
  done
done

echo "${c_dirs} dirs has been created"
echo "${c_files} files has been created"

free=$(free_root_mb)
echo "free= $free"

d_time_end=$(date +'%d.%m.%y_%H:%M:%S')
uptime=$(</proc/uptime)
time_end=${uptime%% *}
time_run=$(bc<<<"scale=1; $time_end - $time_begin" | sed 's/^\./0./')

echo "Script start time ${d_time_start}"
echo "Script end time ${d_time_end}"
echo "Execution time ${time_run} sec"

echo "Script start time ${d_time_start}" >> ${log_file}
echo "Script end time ${d_time_end}" >> ${log_file}
echo "Execution time ${time_run} sec" >> ${log_file}
