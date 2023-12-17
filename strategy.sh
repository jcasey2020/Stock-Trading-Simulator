#!/bin/bash
# define variables
totallines=$(wc -l < finalpricelist.txt)
currentprice=$(awk -v lines=$(wc -l < finalpricelist.txt) '{if (NR == 
lines) print $1}' finalpricelist.txt)
hold=5
# gather user information
while true;
do
 echo Do you want to analyze past or future performance \(0 for 
historical or 1 for future\)
 read strategytype
 if [ "$strategytype" == "0" ]
 then
 echo what percent increase do you want to study? 
\(enter a number. Ex: 2.5\)
 read percentparameter
 break
 elif [ "$strategytype" == "1" ]
 then
 echo Do you currently hold AAPL shares \(Y/N\)?
 read response
 if [ "$response" == "N" ]
 then
 hold=0
 echo what percent increase do you want to see 
before deciding to buy \(enter a number. Ex: 2.5\)
 read percentparameter
 echo over how many minutes do you want to see 
this price increase? \(enter a number. Ex: 5\)
 read buytimeparameter
 echo after how many minutes do you want to 
sell? \(enter a number. Ex: 10\)
 read selltimeparameter
 break
 elif [ "$response" == "Y" ]
 then
 hold=1
 echo At what price do you want to sell your 
shares? \(enter a number. Ex: 195.50\)
 read sellpriceparameter
 break
 fi
 fi
done
# execute strategy 1 (Historical Comparison)
if [[ "$strategytype" -eq 0 ]]; then
 linenumber=0
 numeric_currentprice=$(echo "$currentprice" | sed 's/\$//')
 while read -r line; do
 linenumber=$((linenumber + 1))
 oldprice=$(echo "$line" | awk '{print $1}' | tr -d ' $')
 oldtime=$(echo "$line" | awk -F '|' '{print $2}')
 linenumber2=0
 while read -r line2; do
 linenumber2=$((linenumber2 + 1))
 if [ "$linenumber2" -gt "$linenumber" ]; then
 oldprice2=$(echo "$line2" | awk '{print $1}' | tr -d ' 
$')
 oldtime2=$(echo "$line2" | awk -F '|' '{print $2}')
 result=$(awk -v current="$oldprice2" -v 
old="$oldprice" 'BEGIN {print ((current * 100 / old) - 100)}')
 threshold=$(awk -v percent="$percentparameter" 'BEGIN 
{print percent}')
 if [ "$(awk -v result="$result" -v 
threshold="$threshold" 'BEGIN {print (result >= threshold) ? 1 : 0}')" 
-eq 1 ]; then
 echo "between $oldtime and $oldtime2, AAPL 
increased by $result%"
 fi
 fi
 done < finalpricelist.txt
 done < finalpricelist.txt
fi
# ./recordprice.sh MUST be running in the background
if [ "$hold" -eq 0 ]
# execute Strategy 2 (Real-time Buying Decision)
then
 while true; do
 oldprice=$(awk -v newestline=$(wc -l < 
finalpricelist.txt) 'NR == newestline - '"$buytimeparameter"'' 
finalpricelist.txt)
 numeric_currentprice=$(echo "$currentprice" | sed 
's/\$//')
 numeric_oldprice=$(echo "$oldprice" | sed 's/\$//')
 result=$(awk -v current="$numeric_currentprice" -v 
old="$numeric_oldprice" 'BEGIN {print (current * 100 / old)}')
 threshold=$(awk -v percent="$percentparameter" 'BEGIN 
{print 100 + percent}')
 if [ "$(awk -v result="$result" -v 
threshold="$threshold" 'BEGIN {print (result >= threshold) ? 1 : 0}')" 
-eq 1 ]
 then
 echo BUY THE STOCK
 purchaseprice=$currentprice
 purchasetime=$(awk -v lines=$(wc -l < 
finalpricelist.txt) '{if (NR == lines) print $3}' finalpricelist.txt)
 hold=1
 echo you purchased at $purchasetime for 
$purchaseprice
 sleep $(($selltimeparameter * 60))
 sellprice=$(awk -v lines=$(wc -l < 
finalpricelist.txt) '{if (NR == lines) print $1}' finalpricelist.txt)
 selltime=$(awk -v lines=$(wc -l < 
finalpricelist.txt) '{if (NR == lines) print $3}' finalpricelist.txt)
 echo you sold at $selltime for $sellprice
 break
 else
 echo Waiting for the current price to reach or 
exceed the sell price parameter...
 sleep 60
 fi
 done
elif [ "$hold" -eq 1 ]
# execute Strategy 3 (Real-time Buying Decision)
then
 while true; do
 currentprice=$(awk -v lines=$(wc -l < 
finalpricelist.txt) '{if (NR == lines) print $1}' finalpricelist.txt)
 numeric_price=$(echo "$currentprice" | sed 's/\$//')
 if [ $(bc <<< "$numeric_price >= $sellpriceparameter") 
-eq 1 ]
 then
 selltime=$(awk -v lines=$(wc -l < 
finalpricelist.txt) '{if (NR == lines) {for (i = 3; i <= NF; i++) 
printf "%s ", $i; print ""}}' finalpricelist.txt)
 echo you sold at $selltime for $currentprice
 break
 else
 echo Waiting for the current price to reach or 
exceed the sell price parameter...
 sleep 60
 fi
 done
fi
