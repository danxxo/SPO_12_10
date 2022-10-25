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
