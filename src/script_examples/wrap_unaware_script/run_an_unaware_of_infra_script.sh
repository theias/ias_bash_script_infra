#!/bin/bash

all_arguments=( "$@" )

# shellcheck disable=SC1091
. /opt/IAS/lib/bash4/IAS/BashInfra/full_project_lib.sh || exit 1

program_to_run="$(get_bin_dir)/unaware_of_infra_script.sh"

write_log_start "${all_arguments[@]}"

output_file_name=$(get_output_file_name)

program_base_name=$( basename "$program_to_run" )
write_log_informational "Running: $program_to_run"

"$program_to_run" > "$output_file_name" \
	2> >( sed "s/^/$program_base_name stderr:/" | write_log_informational )

exit_status_of_unaware_script=$?

if [[ $exit_status_of_unaware_script == 0 ]]
then
	write_log_informational "$program_to_run" exited fine.
else
	write_log_error "$program_to_run" failed to run.  Please check logs.
fi

exit_status=0 # Whatever we want, based off of how things go

write_log_informational "Wrote: ${output_file_name}"
write_log_informational "Exit status: ${exit_status}"

write_log_end

exit $exit_status

