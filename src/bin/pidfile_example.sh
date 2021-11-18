#!/bin/bash

# This is an example script for how to use the PidFile.sh library
# It, by default, will count to 10 and sleep for one second for each value.
# You can try to run another instance of the script while it's running, and
# that other instance should exit.
#
# This script should clean up its pidfile after itself (provided
# it's not interrupted) and should run if the process ID
# in a stale pidfile is not running (checked via kill -0)
#
# The (optional) first argument to this script is how high to count.

# Please note, that the PATH variable manipulation done here shouldn't
# be necessary if you're "linking" against the installed version of this
# project.  If you have this project installed, you can (and should) replace:
# 	. PidFile.sh
# with
#	. /opt/IAS/lib/bash4/IAS/BashInfra/PidFile.sh
rp=$(dirname "$(realpath "$0")")
libdir="$rp/../lib/bash4"
bash_infra_lib_dir="IAS/BashInfra"
PATH="${libdir}/$bash_infra_lib_dir:/opt/IAS/lib/bash4/$bash_infra_lib_dir:${PATH}"

. PidFile.sh

to=${1:-10}

# This is how you change the location of the pidfile dir:
# pidfile_dir=/var/tmp
pidfile=$(get_pidfile_name)

echo "Pidfile name: $pidfile"
if ! init_pid_file "$pidfile" "0.2" 
then
	>&2 echo "Process from $pidfile is running..."
	exit 1
fi
	

for i in $(seq 1 "$to")
do
	date
	echo "Loop $i"
	sleep 1
done


cleanup_pidfile "$pidfile"
