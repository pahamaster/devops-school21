#!/bin/bash
reg="^[+-]?[0-9]+(\.[0-9]+)?$"

if [ "$#" -eq 0 ]
  then echo "Error: no arguments"
elif [ "$#" -ne 1 ]
  then
  echo "Error: to many arguments"
elif [[ "$1" =~ $reg ]]
  then
  echo "Error: incorrect input"
else
  echo $1
fi

