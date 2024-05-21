#!/bin/bash

# Should be run by a cron from the root of the user. The metrics file is created there too

. ./cpu.sh
. ./free_hd.sh
. ./free_ram.sh

html="/var/www/html/metrics/index.html"
mkdir -p /var/www/html/metrics

while true; do
  rm -rf "$html"
  scrape_cpu
  scrape_free_hd_space
  scrape_free_mem
  sleep 5;
done
