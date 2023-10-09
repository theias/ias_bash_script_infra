#!/bin/bash

set -e

# This test assumes that / is owned by root.

# Bootstrap testing infrastructure
this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
my_lib_dir=${my_lib_dir:-"$this_dir/../lib"}
. "$my_lib_dir/bash5/IAS/Tests/Bootstrap.bash"
. "$test_etc_dir/test_config.bash"
# End bootstrap

# This dumps some of the variables that are available:
# debug_test_project_paths

# Your tests begin here.  Here's an example.
# Load the project's bash_lib.sh
. "$project_lib_dir/bash4/IAS/BashInfra/home_dir.sh" || exit 1


IAS_INFRA_HOME_DIR_TYPE=path_owner IAS_INFRA_HOME_DIR_PATH=/

home_dir=$(get_IAS_infra_home_dir)

printf "IAS_INFRA_HOME_DIR_TYPE: %s\n" "$IAS_INFRA_HOME_DIR_TYPE"
printf "Home dir: %s\n" "$home_dir"
roots_home_dir=$( printf '%s' ~root)

if [[ "$home_dir" == "$roots_home_dir" ]]
then
	exit 0
else
	exit 1
fi

