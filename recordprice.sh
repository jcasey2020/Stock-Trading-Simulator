#!/bin/bash
echo Enter stock ticker
read ticker
while [ 1 -eq 1 ]
do
 ./ticker.sh $ticker > tempprices.txt
 ./cleanfile.sh < tempprices.txt > cleanprices.txt
 awk 'NR==6 {field5=$5} NR==8 {field0=$0} END {print field5, 
"|", field0}' cleanprices.txt >> finalpricelist.txt
 echo "" > tempprices.txt
 echo "" > cleanprices.txt
 sleep 60
done
