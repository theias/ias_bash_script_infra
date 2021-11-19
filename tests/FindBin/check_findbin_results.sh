#!/bin/bash

script_dir=$(dirname "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}")

if [[ -z "$0" ]]
then
	script_dir=$( dirname $(realpath "$0") )
else
	:
fi

function filter_the_results
{
	sed -s 's/\.pl$//' | sed -s 's/\.sh$//'
}

function check_real_bin
{
	diff <( "$script_dir/real_dir/real_bin.pl" | filter_the_results ) \
		 <( "$script_dir/real_dir/real_bin.sh" | filter_the_results )
}

function check_sym_bin
{
	diff <( "$script_dir/sym_dir/real_bin.pl" | filter_the_results ) \
		 <( "$script_dir/sym_dir/real_bin.sh" | filter_the_results )
}

