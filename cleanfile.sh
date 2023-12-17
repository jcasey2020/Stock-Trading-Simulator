#!/bin/bash
echo "Use: ./cleanfile.sh < input > output"
shopt -s extglob # Enable Bash Extended Globbing expressions
 IFS=
 while read -r line || [[ "$line" ]]; do
 echo "${line//$'\e'[\[(]*([0-9;])[@-n]/}"
 done
