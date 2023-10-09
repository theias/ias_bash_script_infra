#!/bin/bash

set -e

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

home_dir=$(get_IAS_infra_home_dir)

printf "IAS_INFRA_HOME_DIR_TYPE: %s\n" "$IAS_INFRA_HOME_DIR_TYPE"
printf "Home dir: %s\n" "$home_dir"

