#!/bin/bash

function scrape_cpu {
	echo "# HELP cpu_used_in_percent The total CPU used as percent value" >> "$html"
	echo "# TYPE cpu_used_in_percent gauge" >> "$html"
	echo "cpu_used_in_percent $(ps -eo pcpu | awk '{s+=$1} END {print s}')" >> "$html"
}
