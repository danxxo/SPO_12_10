#!/bin/bash

declare a_string # 1st string
declare b_string # 2nd string
declare word="Longest(a, b) --> "
declare unique_string=""
declare answer=""
declare string=""

# reading
echo -n "a = "
read a_string
echo -n "b = "
read b_string

# problems proccesing
if [[ -z $a_string ]] && [[ -z $a_string ]]; then
	echo "Nothing to sort"
	exit 0
elif [[ -z $a_string ]]; then
	word="Longest(b, b) --> "
	a_string=$b_string
elif [[ -z $b_string ]]; then
	word="Longest(a, a) --> "
	b_string=$a_string
fi

#This function is checking number among symbols. If digit is detected, then throw a error
function isLetter() {
	declare if_letter='^[a-zA-Z]+$' # if letter checker
	letter=$@
	if ! [[ $letter =~ $if_letter ]]; then
		echo you have $letter in one of your strings
		echo strings must be consisted of only chars and no spaces
		exit 1
	fi
}

# function for string proccesing
# we iterate in the string using i
# check if string[i] is letter
# while we are itearting through string
# we create new string unique_string that concists of only unique chars
# if we meet char that we dont met yet
# we increase j. after that we compare j and unique_string.size()
# if we met unique char, our j will be > unique_string.size()
# so we add unique char to it
function string_proccesing() {
	string=$@	

	for ((i=0;i<${#string};++i)); do
		isLetter ${string:$i:1}
		j=0

		for ((k=0;k<${#unique_string};k++)); do
			ascii_number=$(echo -n ${string:$i:1} | od -An -tuC)
			unique_string_ascii_number=$(echo -n ${unique_string:$k:1} | od -An -tuC)
			if [[ $ascii_number -ne $unique_string_ascii_number ]]; then
				j=$(( $j + 1 ))
			fi
		done
		if [[ $j -eq ${#unique_string} ]]; then
			unique_string+=${string:$i:1}
		fi
	done
}

# procces our strings and fill unique_string with unique chars from a and b
string_proccesing $a_string

string_proccesing $b_string

# sorting our symbols in unique_string
# we work while our string is not empty
# max = 123 because it is more than max ascii number of alphabet(z_ascii = 122)
# we sort our string from greates ascii to lowest
# when we find max_ascii make answer.push_front('symbol_with_max_ascii') 
# then we delete that symbol from unique_string using tr utility
# can see tr --help, -d is for delete
while [ ${#unique_string} -ne 0 ]; do
	max_ascii_number=123
	for ((i=0;i<${#unique_string};i++)); do
		unique_string_ascii_number=$(echo -n ${unique_string:$i:1} | od -An -tuC)
		if [[ $unique_string_ascii_number -lt $max_ascii_number ]]; then
			max_ascii_number=$unique_string_ascii_number
		fi
	done
	
	max_ascii_symbol=$(printf "\x$(printf %x $max_ascii_number)")
	answer+=$max_ascii_symbol
	
	#deleting
	unique_string=$(echo $unique_string | tr -d $max_ascii_symbol)
done

echo -n "$word"
echo $answer

exit 0
