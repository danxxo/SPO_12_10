#!/bin/bash

# function for replacing elements inside massive
# takes two input parametres and swap it

swap() {
	tmp=${phrase[$1]}
	phrase[$1]=${phrase[$2]}
	phrase[$2]=$tmp
}

# function that takes the string, read every element
# if element is a char with down_register, it change it to up_register and add to string 
# using tr command utility, can see tr --help

up_register() {
	string=$@

	for ((i=0; i<${#string}; i++)); do
		char=${string:$i:1}
		char_ascii=$(echo -n $char | od -An -tuC)
		 
		if [[ $char_ascii -gt 96 ]] && [[ $char_ascii -lt 123 ]]; then
			char_ascii=$(( $char_ascii - 32 ))
			char_up=$(printf "\x$(printf %x $char_ascii)")
			string=$(echo $string | tr $char $char_up )
		fi	
	done
}

# function that takes the string, read every element
# if element is a char with up_register, it change it down_register and add to string 
# using tr command utility, can see tr --help

down_register() {
	string=$@

	for ((i=0; i<${#string}; i++)); do
		char=${string:$i:1}
		char_ascii=$(echo -n $char | od -An -tuC)
		 
		if [[ $char_ascii -gt 64 ]] && [[ $char_ascii -lt 91 ]]; then
			char_ascii=$(( $char_ascii + 32 ))
			char_up=$(printf "\x$(printf %x $char_ascii)")
			string=$(echo $string | tr $char $char_up )
		fi	
	done
}

# reading phrase -p to write before reading
# -r need to turn off escape symbols
# -a read to array

read -p "Please write your phrase: " -r -a phrase

# sorting massive "phrase"
# we need to make phrase[0] <= phrase[1] >= phrase[2] <= ...
# if index is odd we check if phr[i] > phr[i+1], then swipe i and i+1
# if index is non-odd we check phr[i] < phr[i+1], then swipe them
for (( i = 0; i < ${#phrase[@]}-1; i++ )); do
	if ((i % 2)); then
		if (( ${#phrase[$i]} < ${#phrase[$(($i + 1))]} )); then
			swap $i $(($i + 1))
		fi
	else
		if (( ${#phrase[$i]} > ${#phrase[$(($i + 1))]} )); then
			swap $i $(($i + 1))
		fi
	fi
done

# writing sorted massive and up or down register of elements
for ((j=0; j<${#phrase[@]}; j++)); do
	if (($j % 2)); then 
		string=${phrase[$j]}
		up_register $string
		echo -n $string" "
	else 
		string=${phrase[$j]}
		down_register $string
		echo -n $string" "

	fi
done
echo
exit 0
