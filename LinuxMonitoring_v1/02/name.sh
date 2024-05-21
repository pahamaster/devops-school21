#!/bin/bash

echo "HOSTNAME = $HOSTNAME"

timezone=$(</etc/timezone)
shiftzone=$(date +'%Z')
echo "TIMEZONE = $timezone UTC $shiftzone"

echo "USER = $USER"

os=$(cat /etc/*-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/"//g')
echo "OS = $os"

