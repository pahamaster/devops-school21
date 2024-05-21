#!/bin/bash

#ram=$(free --mega | grep -ioE "mem\s*[0-9]+")
#ram=$(free --mega | grep -ioE "mem:\s*[0-9]+" | grep -oE "[0-9]*")
#ramt=$(bc<<<"scale=3;$ram/1000" | sed 's/^\./0./')

div1000 () {
  res=$(bc<<<"scale=3;$1/1000" | sed 's/^\./0./')
  echo $res
}

ram=$(free --mega | grep -i "mem")

ramtotal=$(echo $ram | cut -d ' ' -f 2)
ramtotal=$(div1000 "$ramtotal")

ramused=$(echo $ram | cut -d ' ' -f 3)
ramused=$(div1000 "$ramused")

ramfree=$(echo $ram | cut -d ' ' -f 4)
ramfree=$(div1000 "$ramfree")

echo "RAM_TOTAL = $ramtotal GB"
echo "RAM_USED = $ramused GB"
echo "RAM_FREE = $ramfree GB"
