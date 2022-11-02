#!/bin/bash

#check program args, we need 1 argument
if [ $# != 1 ]; then
	echo argument error...
	echo you gave 0 or more than 1 arg
	exit 1
fi

# check that arg is positive integer
int_proof='^[0-9]+$'
if ! [[ $1 =~ $int_proof ]]; then
	echo argument problems, please check that your argument
	echo is positive integer, your argument = $1
	exit 1
fi

# case if we have 1 person that is first and last 
if [ $1 == 1 ]; then
	echo chair num = 1
fi

# through lot of tries we can notice that last person
# always takes penultmiate chair
echo last person chair num = $(($1 - 1))
exit 0
