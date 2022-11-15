#!/bin/bash

# checking programm arguments
if [ $# -eq 0 ]; then 
	echo "Amnesia..need arguments"
	exit 1
fi

# zero value handling
if (( $1 == 0 )); then
	exit 0
fi

# half rhombus painting
space_counter=$(($1 - 1))
dot_counter=1

# iterator j in 1st cycle goes from 0 to $1, need for painting $1 lines
# iterator j in 2nd cycle goes from 0 to space_counter - 1, need for tabulation
# iterator j in 3d cycle goes from 0 to dot_counter - 1, need for dot painting
# value space_counter need for tabulation, it goes from $1 - 1 to 0
# value dot_counter need for amount of dots in line, it goes from 1 to $1

for((i = 0; i <= $1; i++)); do
	for((i = 0; i < $space_counter; i++)); do
		echo -n "  "
	done

	for((i = 0; i < $dot_counter; i++)); do
		echo -n " .  "
	done
echo
let "space_counter-=1"
let "dot_counter+=1"
done

# half of rhombus's already painted
# updating values
let "space_counter+=2"
let "dot_counter-=2"

# painting second part of rhombus
# iterator j in 1st cycle goes from 0 to $1 - 1, need for painting lines wthout line with $1 dots
# iterator j in 1st cycle goes from $1 to 1, need for tabulation
# iterator j in 2nd cycle goes from 0 to space_counter - 1, need for dot painting
# value space_counter need for tabulation, it goes from 1 to $1
# value dot_counter need for amount of dots in line, it goes from $1 - 1 to 1

for((j = $1; j > 0; j--)); do
	for((j = 0; j < $space_counter; j++)); do
		echo -n "  "
	done
	
	for((j = 0; j < $dot_counter; j++)); do
		echo -n " .  "
	done
echo
let "space_counter+=1"
let "dot_counter-=1"
done
exit 0
