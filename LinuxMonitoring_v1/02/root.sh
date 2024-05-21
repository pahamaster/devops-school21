#!/bin/bash

div1000 () {
  res=$(bc<<<"scale=3;$1/1000" | sed 's/^\./0./')
  echo $res
}

root=$(df | grep -E "\s/$")

spaceroot=$(echo $root | cut -d ' ' -f 2)
spaceroot=$(div1000 $spaceroot)

spacerootused=$(echo $root | cut -d ' ' -f 3)
spacerootused=$(div1000 $spacerootused)

spacerootfree=$(echo $root | cut -d ' ' -f 4)
spacerootfree=$(div1000 $spacerootfree)

echo "SPACE_ROOT = $spaceroot MB"
echo "SPACE_ROOT_USED = $spacerootused MB"
echo "SPACE_ROOT_FREE = $spacerootfree MB"
