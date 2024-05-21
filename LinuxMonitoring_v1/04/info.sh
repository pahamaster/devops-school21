#!/bin/bash

colorName=$1
colorVal=$2

colorDef="\033[0m"

print () {
  len=$((15-${#1}))
  printf '%*s' $len ''|tr ' ' ' '
  printf "${colorName}%s${colorDef} = ${colorVal}%s${colorDef}\n" "$1" "$2"
}

div1000 () {
  res=$(bc<<<"scale=3;$1/1000" | sed 's/^\./0./')
  echo "$res $2"
}

timezone=$(</etc/timezone)
shiftzone=$(date +'%Z')
timezone="$timezone UTC $shiftzone"
os=$(cat /etc/*-release | grep "PRETTY_NAME" | sed 's/PRETTY_NAME=//g' | sed 's/"//g')

date=$(date +'%e %B %Y %H:%M:%S')
uptime=$(uptime -p | sed 's/up //')
uptime_s=$(</proc/uptime)
uptime_s=${uptime_s%%.*}

reg_ip="([0-9]{1,3}\.){3}[0-9]{1,3}"

ip=$(ip a | grep -oE "inet $reg_ip" | grep -v "127.0.0.1" | sed 's/inet //' | sed '2,$d')
ip_m=$(ip a | grep -oE "inet $reg_ip/[0-9]{1,2}" | grep -v "127.0.0.1" | sed 's/inet //' | sed '2,$d')
mask=$(ipcalc $ip_m | grep  "Netmask:" | grep -oE "$reg_ip")
gateway=$(ip r | grep  "default via" | grep -oE "$reg_ip" | sed '2,$d')

ram=$(free --mega | grep -i "mem")
ramtotal=$(echo $ram | cut -d ' ' -f 2)
ramtotal=$(div1000 $ramtotal "GB")
ramused=$(echo $ram | cut -d ' ' -f 3)
ramused=$(div1000 $ramused "GB")
ramfree=$(echo $ram | cut -d ' ' -f 4)
ramfree=$(div1000 $ramfree "GB")

root=$(df | grep -E "\s/$")
spaceroot=$(echo $root | cut -d ' ' -f 2)
spaceroot=$(div1000 $spaceroot "MB")
spacerootused=$(echo $root | cut -d ' ' -f 3)
spacerootused=$(div1000 $spacerootused "MB")
spacerootfree=$(echo $root | cut -d ' ' -f 4)
spacerootfree=$(div1000 $spacerootfree "MB")

print "HOSTNAME" "$HOSTNAME"
print "TIMEZONE" "$timezone"
print "USER" "$USER"
print "OS" "$os"

print "DATE" "$date"
print "UPTIME"  "$uptime"
print "UPTIME_SEC" "$uptime_s"

print "IP" "$ip"
print "MASK" "$mask"
print "GATEWAY" "$gateway"

print "RAM_TOTAL" "$ramtotal"
print "RAM_USED" "$ramused"
print "RAM_FREE" "$ramfree"

print "SPACE_ROOT" "$spaceroot"
print "SPACE_ROOT_USED" "$spacerootused"
print "SPACE_ROOT_FREE" "$spacerootfree"
