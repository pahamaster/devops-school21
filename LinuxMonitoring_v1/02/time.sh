#!/bin/bash

date=$(date +'%e %B %Y %H:%M:%S')
echo "DATE = $date"

uptime=$(uptime -p | sed 's/up //')
echo "UPTIME = $uptime"

uptime=$(</proc/uptime)
uptime=${uptime%%.*}
echo "UPTIME_SEC = $uptime"

