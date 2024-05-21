#!/bin/bash

reg="/$"

if [[ $# -eq 0 ]]; then
  echo "Error: no arguments"
elif [[ ! "$1" =~ $reg ]]; then
  echo "Error: wrong parameter"
elif [[ ! -d $1 ]]; then
  echo "Error: folder not found"
else
  uptime=$(</proc/uptime)
  echo "uptime $uptime"
  time_begin=${uptime%% *}
  echo "time_begin $time_begin"

  ./1.sh "$1"
  ./2.sh "$1"
  ./3.sh "$1"
  uptime=$(</proc/uptime)
  time_end=${uptime%% *}
  time_run=$(bc<<<"scale=1; $time_end - $time_begin" | sed 's/^\./0./')
  echo "Script execution time (in seconds) = $time_run"
fi
