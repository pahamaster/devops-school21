#!/bin/bash

count_files=$(find "$1" -type f | wc -l)
count_conf_files=$(find "$1" -type f -iname "*.conf" | wc -l)
count_log_files=$(find "$1" -type f -iname "*.log" | wc -l)
count_txt_files=$(find "$1" -type f -exec file -i {} \; | grep ":.* text/" | wc -l)
count_arch_files=$(find "$1" -type f -exec file {} \; | grep ":.* archive\\|:.* compressed" | wc -l)
count_exe_files=$(find "$1" -type f -perm /a=x | wc -l)
count_lnk_files=$(find -L "$1" -type l | wc -l)

echo "Total number of files = $count_files"

echo "Number of:"
echo "Configuration files (with the .conf extension) = $count_conf_files"
echo "Text files = $count_txt_files"
echo "Executable files = $count_exe_files"
echo "Log files (with the extension .log) = $count_log_files"
echo "Archive files = $count_arch_files"
echo "Symbolic links = $count_lnk_files"
