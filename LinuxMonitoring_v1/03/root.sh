#!/bin/bash

colorName=$1
colorVal=$2

colorDef="\033[0;39m\033[0;49m"

print () {
  printf "${colorName}${1}${colorDef} = ${colorVal}%s${colorDef}\n" "${2}"
}

div1000 () {
  res=$(bc<<<"scale=3;$1/1000" | sed 's/^\./0./')
  echo "$res MB"
}

root=$(df | grep -E "\s/$")

spaceroot=$(echo $root | cut -d ' ' -f 2)
spaceroot=$(div1000 $spaceroot)

spacerootused=$(echo $root | cut -d ' ' -f 3)
spacerootused=$(div1000 $spacerootused)

spacerootfree=$(echo $root | cut -d ' ' -f 4)
spacerootfree=$(div1000 $spacerootfree)

print "SPACE_ROOT" "$spaceroot"
print "SPACE_ROOT_USED" "$spacerootused"
print "SPACE_ROOT_FREE" "$spacerootfree"
