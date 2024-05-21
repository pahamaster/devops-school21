#!/bin/bash

colorName=$1
colorVal=$2

colorDef="\033[0;39m\033[0;49m"

print () {
  printf "${colorName}${1}${colorDef} = ${colorVal}%s${colorDef}\n" "${2}"
}

print "HOSTNAME" "$HOSTNAME"

timezone=$(</etc/timezone)
shiftzone=$(date +'%Z')
print "USER" "$USER"

os=$(cat /etc/*-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/"//g')
print "OS" "$os"

