#!/bin/bash

rp=$(dirname $(realpath "$0"))
libdir="$rp/../lib/bash4"
bash_infra_lib_dir="IAS/BashInfra"
PATH="${libdir}/$bash_infra_lib_dir:/opt/IAS/lib/bash4/$bash_infra_lib_dir:${PATH}"

. PidFile.sh

to=${1:-10}

pidfile=$(get_pidfile_name)

echo "Pidfile name: $pidfile"
if ! init_pid_file "$pidfile" "0.2" 
then
	>&2 echo "Process from $pidfile is running..."
	exit 1
fi
	

for i in `seq 1 $to`
do
	date
	echo "Loop $i"
	sleep 1
done


cleanup_pidfile "$pidfile"
