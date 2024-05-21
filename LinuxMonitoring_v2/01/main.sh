#!/bin/bash

dir=$1
count_dirs=$2
sym_dir=$3
count_files=$4
sym_file=$5
size_file=$6

reg_dir="^/"
reg_num="^[0-9]+$"
reg_sym1="^[a-zA-Z]{1,7}$"
reg_sym2="([a-zA-Z])(.*?\1)"
reg_sym_file="^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$"
reg_size_file="^[1-9][0-9]?kb$|^100kb$"

date=$(date +'%d%m%y')

if [[ $# -ne 6 ]]; then
  echo "Error: must be 6 arguments. Example: ./main.sh /opt/test 4 az 5 az.az 3kb"
elif [[ ! "$dir" =~ $reg_dir ]]; then
  echo "Error: the first argument must start with a '/'"
elif [[ ! -d $1 ]]; then
  echo "Error: folder not found"
elif [[ ! "$count_dirs" =~ $reg_num ]]; then
  echo "Error: Second argument must be a number"
elif [[ "$sym_dir" =~ $reg_sym2 ]]; then
  echo "Error: Third argument is wrong. Example: asdfghj"
elif [[ ! "$sym_dir" =~ $reg_sym1 ]]; then
  echo "Error: Third argument is wrong. Example: asdfghj"
elif [[ ! "$count_files" =~ $reg_num ]]; then
  echo "Error: the 4th argument must be a number"
elif [[ ! "$sym_file" =~ $reg_sym_file ]]; then
  echo "Error: the 5th argument is wrong. Example: abcdef.def"
elif [[ ! "$size_file" =~ $reg_size_file ]]; then
  echo "Error: the 6th argument is wrong: Example: from 1kb to 100kb"
else
  # echo "OK"
  ./create_dirs.sh ${dir} ${count_dirs} ${sym_dir} ${date}
  ./create_files.sh ${dir} ${count_files} ${sym_file} ${date} ${size_file}
fi
