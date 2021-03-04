#!/bin/bash

max_random=32767
size="${1:-60}"
scale=$((max_random/size))

hostid=$[ 0x`hostid` ]

# echo "$hostid"

# RANDOM=$hostid
value=$RANDOM
# normalized_random=$(( $value / $scale  ))
normalized_random=$(($value/($max_random/$size)))
# echo "Normalized random: " $normalized_random
echo $normalized_random

