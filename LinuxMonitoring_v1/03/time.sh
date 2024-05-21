#!/bin/bash

colorName=$1
colorVal=$2

#colorDef="\033[0;39m\033[0;49m"
colorDef="\033[0m"

print () {
  printf "${colorName}${1}${colorDef} = ${colorVal}%s${colorDef}\n" "${2}"
}

date=$(date +'%e %B %Y %H:%M:%S')
print "DATE" "$date"

uptime=$(uptime -p | sed 's/up //')
print "UPTIME"  "$uptime"

uptime=$(</proc/uptime)
uptime=${uptime%%.*}
print "UPTIME_SEC" "$uptime"

