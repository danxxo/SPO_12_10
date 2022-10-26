#!/bin/bash

echo -n "input: "
read -a chars

amount=${#chars[@]}

if [ $amount = 0 ]; then 
	echo z
	exit 0
fi

sum=0

for (( i = 0; i < amount; i++)); do
	ascii_num=$(($(echo -n ${chars[$i]} | od -An -tuC)-96))
	sum=$(( $sum + $ascii_num ))
done

sum=$(( ($sum % 26) + 96 ))

if [ $sum = 96 ]; then 
	echo z
	exit 0
fi

printf "output: \x$(printf %x $sum)"	
echo
