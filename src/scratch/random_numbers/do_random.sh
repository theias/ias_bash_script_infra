#!/bin/bash

to="${1:-10}"
s="${2:-60}"

for (( c=1; c<=$to; c++ ))
do
	./bash_random.sh $s
done
