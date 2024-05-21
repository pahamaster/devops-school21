#!/bin/bash

top_10_files_max_size=$(find "$1" -type f -exec du -ah {} + | sort -hr | head -10)
top_10_exe_max_size=$(find "$1" -type f -perm /a=x -exec du -ah {} + | sort -hr | head -10)

count_conf_files=$(find "$1" -type f -iname "*.conf" | wc -l)
count_log_files=$(find "$1" -type f -iname "*.log" | wc -l)
count_txt_files=$(find "$1" -type f -exec file {} \; | grep ":.* text" | wc -l)
count_arch_files=$(find "$1" -type f -exec file {} \; | grep ":.* archive\\|:.* compressed" | wc -l)
count_exe_files=$(find "$1" -type f -perm /a=x | wc -l)
count_lnk_files=$(find -L "$1" -type l | wc -l)

echo "TOP 10 files of maximum size arranged in descending order (path, size and type):"
echo "$top_10_files_max_size" | awk -f top10.awk

echo "TOP 10 executable files of the maximum size arranged in descending order (path, size and MD5 hash of file)"
echo "$top_10_exe_max_size" | awk -f top10exe.awk

