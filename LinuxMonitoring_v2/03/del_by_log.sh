#!/bin/bash

log_file=$1

c_files=0
c_dirs=0
c_not_found=0

#free_root () {
#  free=$(df -h / | sed '1d')
#  free=$(echo $free | cut -d ' ' -f 4)
#  echo $free
#}

free_root () {
  free=$(df --block-size=MB / | sed '1d')
  free=$(echo $free | cut -d ' ' -f 4)
  echo ${free}
}

free=$(free_root)
echo "free / ${free}"

# while IFS= read -r line; do
#   # echo "$line"
#   name=$(echo "$line" | awk '{print $1}')
#   # echo "$name"
#   if [[ -d "$name" ]]; then
#     let "c_dirs += 1"
#   elif [[ ! -e "$name" ]]; then
#     let "c_files += 1"
#   fi
#   rm -rf "$name"
# done < "${log_file}"

while IFS= read -r line; do
  # echo "$line"
  name=$(echo "$line" | awk '{print $1}')
  # echo "$name"
  if [[ -f "$name" ]]; then
    let "c_files += 1"
    rm -rf "$name" &>/dev/null
  fi
done < "${log_file}"

while IFS= read -r line; do
  # echo "$line"
  name=$(echo "$line" | awk '{print $1}')
  # echo "$name"
  if [[ ${name:0:1} == "/" ]]; then
    if [[ -d "$name" ]]; then
      let "c_dirs += 1"
      rm -rf "$name" &>/dev/null
    else
      let "c_not_found += 1"
    fi
  fi
done < "${log_file}"

echo "${c_dirs} dirs has been deleted"
echo "${c_files} files has been deleted"
if [[ $c_not_found > 0 ]]; then
  echo "${c_not_found} objects not found"
fi
 
free=$(free_root)
echo "free / ${free}"
