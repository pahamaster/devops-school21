#!/bin/bash

colorName=$1
colorVal=$2

colorDef="\033[0;39m\033[0;49m"

print () {
  printf "${colorName}${1}${colorDef} = ${colorVal}%s${colorDef}\n" "${2}"
}

#ram=$(free --mega | grep -ioE "mem\s*[0-9]+")
#ram=$(free --mega | grep -ioE "mem:\s*[0-9]+" | grep -oE "[0-9]*")
#ramt=$(bc<<<"scale=3;$ram/1000" | sed 's/^\./0./')

div1000 () {
  res=$(bc<<<"scale=3;$1/1000" | sed 's/^\./0./')
  echo "$res GB"
}

ram=$(free --mega | grep -i "mem")

ramtotal=$(echo $ram | cut -d ' ' -f 2)
ramtotal=$(div1000 $ramtotal)

ramused=$(echo $ram | cut -d ' ' -f 3)
ramused=$(div1000 $ramused)

ramfree=$(echo $ram | cut -d ' ' -f 4)
ramfree=$(div1000 $ramfree)

print "RAM_TOTAL" "$ramtotal"
print "RAM_USED" "$ramused"
print "RAM_FREE" "$ramfree"
