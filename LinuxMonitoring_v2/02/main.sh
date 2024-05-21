#!/bin/bash

sym_dir=$1
sym_file=$2
size_file=$3

reg_dir="^/"
reg_num="^[0-9]+$"
reg_sym1="^[a-zA-Z]{1,7}$"
reg_sym2="([a-zA-Z])(.*?\1)"
reg_sym_file="^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$"
reg_size_file="^[1-9][0-9]?[mM]{1}[bB]{1}$|^100[mM]{1}[bB]{1}$"

date=$(date +'%d%m%y')

if [[ $# -ne 3 ]]; then
  echo "Error: must be 3 arguments. Example: ./main.sh az az.az 3Mb"
elif [[ "$sym_dir" =~ $reg_sym2 ]]; then
  echo "Error: The first argument is wrong: Example: qwertyu"
elif [[ ! "$sym_dir" =~ $reg_sym1 ]]; then
  echo "Error: The first argument is wrong: Example: qwertyu"
elif [[ ! "$sym_file" =~ $reg_sym_file ]]; then
  echo "Error: the 2th argument is wrong. Example: abcdefg.def"
elif [[ ! "$size_file" =~ $reg_size_file ]]; then
  echo "Error: the 3th argument is wrong: Example: from 1MB to 100MB"
else
  # echo "OK"
  ./clog.sh ${sym_dir} ${sym_file} ${size_file} ${date}
fi
