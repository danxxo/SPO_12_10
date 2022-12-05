declare if_int='^[0-9]+$'


swap() {
  tmp=${phrase[$1]}
  phrase[$1]=${phrase[$2]}
  phrase[$2]=$tmp
}

up_register() {
string=$@
echo ----------------------------------------
echo input string : $string
for ((i=0; i<${#string}; i++)); do
	char=${string:$i:1}
	char_ascii=$(echo -n $char | od -An -tuC)
	 
	if [[ $char_ascii -gt 96 ]] && [[ $char_ascii -lt 123 ]]; then
		char_ascii=$(( $char_ascii - 32 ))
		char_up=$(printf "\x$(printf %x $char_ascii)")
		string=$(echo $string | tr $char $char_up )
		echo old char : $char , new char : $char_up
	fi	
done
}

read -p "Please write your phrase: " -r -a phrase

for (( i = 0; i < ${#phrase[@]}; i++ )); do
  #если элемент нечетный
  if ((i % 2)); then
    if (( ${#phrase[$i]} < ${#phrase[$(($i + 1))]} )); then
      #если не выдолняется условие P, то меняем местами текущий и следующий
      swap $i $(($i + 1))
    fi

  else
    if (( ${#phrase[$i]} > ${#phrase[$(($i + 1))]} )); then
      #если не выдолняется условие P, то меняем местами текущий и следующий
      swap $i $(($i + 1))
    fi

  fi

done

for i in ${phrase[@]}; do
  echo $i
done


string="haclhLICDBIBUVDdvbidbkkdsbLIDVBIB"
up_register $string

echo $string
exit 0
