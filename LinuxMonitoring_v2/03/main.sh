#!/bin/bash

method=$1

reg_method="^[1-3]$"
reg_dir="^/"
reg_num="^[0-9]+$"
reg_sym1="^[a-zA-Z]{1,7}$"
reg_sym2="([a-zA-Z])(.*?\1)"
reg_sym_file="^[a-zA-Z]{1,7}\.[a-zA-Z]{1,3}$"
reg_size_file="^[1-9][0-9]?Mb$|^100Mb$"

# reg_date="^((((0[13578])|([13578])|(1[02]))[\/](([1-9])|([0-2][0-9])|(3[01])))|(((0[469])|([469])|(11))[\/](([1-9])|([0-2][0-9])|(30)))|((2|02)[\/](([1-9])|([0-2][0-9]))))[\/]\d{4}$|^\d{4}$"
# 13 aug 2023 15:00 01:00 23:00 23:59

# reg_date="^([0-3][0-9]){1} [a-zA-Z]{3} [0-9]{4} ([0-2]?[0-9]{1}:[0-6]{1}[0-9]{1})$"
reg_date="^[0-3][0-9] [a-zA-Z]{3} [0-9]{4} [0-2]?[0-9]:[0-5][0-9]$"
reg_mask="^[a-zA-Z]{1,7}_[0-9]{6}$"

if [[ $method == 1 ]]; then
  log_file=$2
  if [[ ! -f ${log_file} ]]; then
    echo "Error: The log file not found"
  else 
    ./del_by_log.sh ${log_file}
  fi
elif [[ $method == 2 ]]; then
  start=$2
  end=$3
  if [[ ! "$start" =~ $reg_date  || ! "$end" =~ $reg_date ]]; then
    echo 'Error in the 2st or 3th argument. Example for any: "10 aug 2023 15:30"'
  else
    ./del_by_date.sh "$start" "$end"
  fi
elif [[ $method == 3 ]]; then
  mask=$2
  if [[ ! "$mask" =~ $reg_mask ]]; then
    echo "Error in the 2st argument. Example: asdqwer_110823"
  else
    ./del_by_mask.sh "$mask"
  fi
else 
  echo "Error: The 1st argument must be from 1 to 3"
fi

# if [[ $# -ne 2 ]]; then
#   echo "Error: must be 3 arguments"
# elif [[ "$sym_dir" =~ $reg_sym2 ]]; then
#   echo "Error: The first argument is wrong: Example: qwertyu"
# elif [[ ! "$sym_dir" =~ $reg_sym1 ]]; then
#   echo "Error: The first argument is wrong: Example: qwertyu"
# elif [[ ! "$sym_file" =~ $reg_sym_file ]]; then
#   echo "Error: the 2th argument is wrong. Example: abcdef.def"
# elif [[ ! "$size_file" =~ $reg_size_file ]]; then
#   echo "Error: the 3th argument is wrong: Example: from 1Mb to 100Mb"
# else
#   # echo "OK"
#   ./1.sh ${sym_dir} ${sym_file} ${size_file} ${date}
# fi
