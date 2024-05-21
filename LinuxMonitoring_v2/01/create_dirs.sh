#!/bin/bash

dir=$1
count_dirs=$2
sym_dir=$3
date=$4

# count_files=$4
# sym_file=$5
# let r_arg="count_dirs / ${#sym_dir}"
# echo "${r_arg}"

log_file="${date}.log"
log_file_dirs="${date}_dirs.log"
echo -n > ${log_file_dirs}

#date=$(date +'%d%m%y')
#echo "$date"

# for ((i=0; i<count_dirs; i++)); do
#   name=$(./gen_n_file.sh ${sym_dir} ${r_arg})
#   name="${dir}/${name}_${date}"
#   while [[ -d ${name} ]] ; do
#     name=$(./gen_n_file.sh ${sym_dir} ${r_arg})
#     name="${dir}/${name}_${date}"
#   done
#   mkdir "${name}"
#   date_time=$(date +'%d.%m.%y_%H:%M:%S')
#   echo "${name} ${date_time}" >> ${log_file}
#   echo "${name}" >> ${log_file_dirs}
# done

add_sym () {
  str=$1
  len=${#1}
  i=$(($RANDOM % ${len}));

  res="${str:0:${i}+1}${str:${i}}"
  echo ${res}
}

name=$sym_dir

for ((i=0; i<count_dirs; i++)); do
  full_name="${dir}/${name}_${date}"
  while [[ -e ${full_name} || ${#name} -lt 4 ]] ; do
    name=$(add_sym "$name")
    full_name="${dir}/${name}_${date}"
  done
  mkdir "${full_name}"
  date_time=$(date +'%d.%m.%y_%H:%M:%S')
  echo "${full_name} ${date_time}" >> ${log_file}
  echo "${full_name}" >> ${log_file_dirs}
done
