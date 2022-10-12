#!/bin/bash

#проверяем есть ли входные аргументы
if [ $# -eq 0 ];
then 
echo "Amnesia..need arguments"
exit 1
fi

# проверка четности входного аргумента
odd_or_honest=$(($1 % 2))

if(($odd_or_honest))
then
dot_counter=1
else
dot_counter=2
fi

#рисование
space_counter=$(($1 / 2))

for((i = 0; i < $1; i++))
do
	for((i = 0; i < $space_counter; i++))
	do
	echo -n " "
	done

		for((i = 0; i < $dot_counter; i++))
		do
		echo -n "."
		done
echo
let "space_counter-=1"
let "dot_counter+=2"
done

let "space_counter+=2"
let "dot_counter-=4"

for((j = $1; j > 0; j--))
do
	for((j = 0; j < $space_counter; j++))
	do
	echo -n " "
	done
		for((j = 0; j < $dot_counter; j++))
		do
		echo -n "."
		done
echo
let "space_counter+=1"
let "dot_counter-=2"
done
