#!/bin/bash

# This file was just copied from a Makefile from before
# when I didn't have a good test boiler plate infra.

# This does a couple of interesting things which might be better
# than not doing interesting things.
#
# It runs the "good" process in a subshell, which should run for (at least) 3 seconds
# It sleeps for 1 second
# It runs a second process which is supposed to detect the first process running
# Then it sleeps for an additional 3 seconds (necessary) so that the first process
# has time to exit.
#
# Yeah, it's a set of race conditions, but that's what this pidfile stuff
# is at least supposed to mitigate.

# Bootstrap testing infrastructure

this_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
my_lib_dir=${my_lib_dir:-"$this_dir/../lib"}
. "$my_lib_dir/bash5/IAS/Tests/Bootstrap.bash"
. "$test_etc_dir/test_config.bash"
# End bootstrap

export pidfile_dir=`mktemp -d` && \
echo "pidfile_dir: $$pidfile_dir" && \
( "$project_bin_dir"/pidfile_example.sh 3 & ) && \
sleep 1 && \
! "$project_bin_dir"/pidfile_example.sh && \
sleep 3 && \
rmdir "$pidfile_dir"

