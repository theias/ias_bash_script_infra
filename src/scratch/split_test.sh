#!/bin/bash

function is_dir_in_src_dir
{
	# Returns true if a path ends with src/something
	local dir=$( dirname "$1")
	dir=$(basename $dir)

	if [[ "$dir" = "src" ]]
	then
		return 0
	fi
	return 1

}

script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
real_script_dir=$(realpath "$script_dir")
PATH="$real_script_dir/../lib/bash4:$PATH"

# . "$DIR/bash_lib.sh"
# string='Paris, France, Europe';
# readarray -td '' a < <(awk '{ gsub(/, /,"\0"); print; }' <<<"$string, "); unset 'a[-1]';
# declare -p a;

test_dir="$script_dir"
# test_dir="/opt/ias/bin/blah//src//blah////"

echo "Test dir: $test_dir"
if is_dir_in_src_dir "$test_dir"
then
	echo "Yes."
else
	echo "No."
fi
