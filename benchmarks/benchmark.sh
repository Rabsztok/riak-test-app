#!/bin/bash

rm test.log

output_file=test.log

grep "GET\|Load" $1 | while read -r line ; do
	if [[ $line =~ "GET" ]]; then
		date=`echo $line | awk '{print $8}'`
	elif [[ $line =~ "Load" ]]; then
		time=`echo $line | awk '{print $3}' | sed -n -e '/^[^(]*(\([^)]*\)).*/s//\1/p'`
	fi
	echo -e $date"\t"$time >> $output_file
done