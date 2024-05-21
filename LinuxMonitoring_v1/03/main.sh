#!/bin/bash

function Color () {
  local background=$1
  local foreground=$2

  case "$foreground" in
    "6" )       colorString='\033[30m';; # Black
    "2" )         colorString='\033[31m';; #Red
    "3" )       colorString='\033[32m';; #Green
    "4" )        colorString='\033[34m';; #Blue
    "5" )     colorString='\033[35m';; #Purple
    "1" )       colorString='\033[97m';; #White
    *)              colorString='\033[0;39m';;
  esac

  case "$background" in
    "6" )       colorString="${colorString}\033[40m";; #Black
    "2" )         colorString="${colorString}\033[41m";; #Red
    "3" )       colorString="${colorString}\033[42m";; #Green
    "4" )        colorString="${colorString}\033[44m";; #Blue
    "5" )     colorString="${colorString}\033[45m";; #Purple
    "1" )       colorString="${colorString}\033[107m";; # White
    *)              colorString="${colorString}\033[49m";;
  esac

  echo "${colorString}"
}

reg="^[1-6]$"

if [ "$#" -lt 4 ]
then
  echo "Error: Must be four parameters. Please, run script again"
elif [[ $1 =~ $reg && $2 =~ $reg && $3 =~ $reg && $4 =~ $reg ]]
then
  if [[ $1 -eq $2 || $3 -eq $4 ]]
  then
    echo "Error: Font and background colors must not match. Please, run script again"
  else
    colorName=$(Color $1 $2)
    colorVal=$(Color $3 $4)

    ./name.sh $colorName $colorVal
    ./time.sh $colorName $colorVal
    ./net.sh $colorName $colorVal
    ./ram.sh $colorName $colorVal
    ./root.sh $colorName $colorVal
  fi
else
  echo "Error: All parameters must be numbers from 1 to 6. Please, run script again"
fi
