#!/bin/bash

to=${to:-5}

unaware_script_exit_status=${unaware_script_exit_status:-0}

for i in {1..6}
do
	date
	echo "Hello, $i"
	>&2 echo "Stderr $i"
done

if [[ $unaware_script_exit_status == 0 ]]
then
	:
else
	>&2 echo "I'm supposed to exit poorly."
fi

exit $unaware_script_exit_status
