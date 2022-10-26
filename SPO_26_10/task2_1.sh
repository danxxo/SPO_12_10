#!/bin/bash

echo "input: " $*
str=""
for param in $@ ; do
str="$param $str"
done
echo "outup:" $str
