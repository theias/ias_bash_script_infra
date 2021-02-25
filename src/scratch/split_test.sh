#!/bin/bash

function get_project_whence
{
	echo "$script_dir"
}

function is_dir_in_src_dir
{
	# Returns true if a path ends with src/something
	local dir_arg="$1"
	# echo "Passed: $dir_arg"
	local dir="${dir_arg:-`get_project_whence`}"
	# echo "Examaning: $dir"

	dir=$(dirname "$dir")
	dir=$(basename "$dir")

	if [[ "$dir" = "src" ]]
	then
		return 0
	fi
	return 1

}

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
real_script_dir=$(realpath "$script_dir")
PATH="$real_script_dir/../lib/bash4:$PATH"


if is_dir_in_src_dir "$@"
then
	echo "Yes."
else
	echo "No."
fi
