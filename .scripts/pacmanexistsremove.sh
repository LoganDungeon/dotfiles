#!/bin/bash

# create the regular expression
existsregex="\b.+: (.*) exists in filesystem"
packageregex="error: No package owns"

while IFS='' read -r line || [[ -n "$line" ]]; do
	#echo "Text read from file: $line"
	if [[ $line =~ $existsregex ]]; then
		file=${BASH_REMATCH[1]}
		output=$(sudo pacman -Qo $file 2>&1)
		if [[ $output =~ $packageregex ]]; then
			#echo $output
			echo "removing $file"
			sudo rm $file
		else
			echo nö
		fi		
	fi
done < "$1"
