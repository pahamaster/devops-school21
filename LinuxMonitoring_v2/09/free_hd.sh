#!/bin/bash

function scrape_free_hd_space {
	echo "# HELP free_hd_space_in_bytes The total number of bytes free in home directory" >> "$html"
	echo "# TYPE free_hd_space_in_bytes gauge" >> "$html"
	echo "free_hd_space_in_bytes $(df -B1 / | awk 'NR==2{print $4}')" >> "$html"
}
