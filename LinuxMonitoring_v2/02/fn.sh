#!/bin/bash

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
  free=$(df -h / | sed '1d')
  free=$(echo $free | cut -d ' ' -f 4)
  echo ${free}
}

free_root_mb () {
  free=$(df --block-size=MB / | sed '1d')
  free=$(echo $free | cut -d ' ' -f 4)
  echo ${free}
}