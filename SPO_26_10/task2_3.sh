#!/bin/bash

declare string
declare shifting
declare new_letter=""
declare answer=""

# if int checker
if_int='^[0-9]+$'

echo your input text must be consisted of UP-register-letters, numbers and non-alphabet symbols 
echo -n "Your text = "
read string
echo -n "Shift = "
read shifting

#check shifting is int
if ! [[ $shifting =~ $if_int ]]; then 
echo shifting must be integer, smth went wrong
echo your \"shifting\" is: $shifting
exit 1
fi

# function for shifting letters
function shifting() {
	# get function parameter
	ascii_number=$@

	# plus shifting
	shifted_ascii_number=$(( $ascii_number + $shifting ))

	# checking new number for making cycle shifting
	while [[ shifted_ascii_number -gt 90 ]]; do
		shifted_ascii_number=$(( $shifted_ascii_number - 26 ))
	done

	return $shifted_ascii_number
}

# function for calculating numbers
function for_numbers() {
	# take parameter
	digit=$@

	# make operation
	digit=$(( 9 - $digit ))
	return $digit
}

# working with input string
# ${#string} = string.size()

for ((i = 0; i < ${#string}; i++)); do

	# read char from string
	char=${string:$i:1}

	# take the ascii_number of input char using od -An -tuC
	# od is octal dump, it gives the octal number of input
	# -An takes the second byte
	# -tuC removes the shifts
	ascii_number=$( echo -n $char | od -An -tuC )

	#checking if char is letter
	if [[ $ascii_number -gt 64 ]] && [[ $ascii_number -lt 91 ]]; then
		shifting $ascii_number
		
		#"$?" is meaning that we get the last value from our returned function
		ascii_number=$?
		
		# as the starting condition says we 
		#decrease register of odd(iterator in string) letters
		
		if [[ $(( $i % 2 )) == 0 ]]; then
			# given : a = 65 decimal integer
			# printf %x $a gives us 41 in hex = 65 in decimal
			# printf "\x $HEX_a" takes hex number and give ascii_letter 
			# for a=65 in decimal we recieve A in ascii
			
			new_letter+=$(printf "\x$(printf %x $ascii_number)")
		else 
			# to decrease register we add 32 to ascii_number
			# (ex. A = 65, a = 97 in ascii)
			
			new_letter+=$(printf "\x$( printf %x $(( $ascii_number + 32 )))")
		fi
	# else if our char is number 0-9
	elif [[ $ascii_number -lt 58 ]] && [[ $ascii_number -gt 47 ]]; then
		for_numbers $char
		char=$?
		new_letter+=$char
	else
		new_letter+=$char
	fi	
done

# text reversing
for ((i = ${#new_letter}; i != -1; i--)); do
	char=${new_letter:$i:1}
	answer+=$char
done
echo answer: \"$answer\"
