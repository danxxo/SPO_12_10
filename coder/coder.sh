#!/bin/bash

# checking arg to be decimal integer or binary
decimal_int='^[0-9]+$'
binary_int='^[0-1]+$'

# checking 1st arg to code, check 2nd arg like decimal integer 
if [[ $1 == "-c" ]]; then
	if ! [[ $2 =~ $decimal_int ]]; then
		echo "You added -c (code) modifyier, second arg must be integer"
		echo "Your argument : " $2
		exit 1
	fi
	
	# output
	echo "your number : " $2
	echo -ne "coded number : "
	
	# num keeps value of input decimal integer
	# num_amount keeps value of amount of digits of num
	num=$2
	num_amount="${#num}"
	
	# in cycle we take one digit from num and give it to num_digit
	# cnt is counter
	# number_base_two is binary number of num_digit
	# we use echo "obase=2"; num | bc to convert into binary using basic calc(bc)
	# k is number of digits [0..1] in number_base_two
	for (( cnt=0; $cnt < $num_amount; cnt++ )); do
		num_digit=${num:$cnt:1}
		number_base_two=$(echo "obase=2; $num_digit" | bc)
		k=$((${#number_base_two} - 1))
		for (( cntk=0; cntk < k; cntk++ )); do
			echo -ne "0" 
		done
		echo -ne "1"$number_base_two 
	done
	echo
	exit 0
fi

# check 1st arg, check 2nd arg to be binary number
if [[ $1 == "-d" ]]; then
	if ! [[ $2 =~ $binary_int ]]; then 
		echo "You added -d (decode) modifyier, second arg must be binary number"
		echo "Your argument : " $2
		exit 1
	fi
	
	#outut
	echo  "your number : " $2
	echo -ne "decoded number : "
	
	# coded_number is input binary number that need to be decoded
	# cnt_zero is zero counter
	coded_number=$2
	cnt_zero=1
	
	# we do cycle while our counter != number of digits in coded_number aka input
	# if extracted digit from coded number == 0 we ++cnt and cnt_zero while we meet 1
	# when we meet 1 we extract coded number from cnt on cnt_zero symbols
	while [[ $cnt != ${#coded_number} ]];  do
		if [[ ${coded_number:$cnt:1} == "0" ]]; then
			((cnt_zero++))
			((cnt++))
		else
			((cnt++))
			
			# echo $(( base#$your_number )) returns your number in need base
			echo -ne $((2#${coded_number:$cnt:$cnt_zero}))
			cnt=$(($cnt_zero + $cnt))
			cnt_zero=1
		fi
	done
	echo
	exit 0 
fi

# if we dont meet flags or smth else we send message with information		
echo something go wrong
echo "use: -c to code, -d to decode. Your modifyier : " $1
exit 1	
