#!/bin/bash

ip=$(ip a | grep -oE "inet ([0-9]{1,3}\.){3}[0-9]{1,3}" | grep -v "127.0.0.1" | sed 's/inet //' | sed '2,$d')
echo "IP = $ip"

ip=$(ip a | grep -oE "inet ([0-9]{1,3}\.){3}[0-9]{1,3}/[0-9]{1,2}" | grep -v "127.0.0.1" | sed 's/inet //' | sed '2,$d')
mask=$(ipcalc $ip | grep  "Netmask:" | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}")
echo "MASK = $mask"

gateway=$(ip r | grep  "default via" | grep -oE "([0-9]{1,3}\.){3}[0-9]{1,3}" | sed '2,$d')
echo "GATEWAY = $gateway"

