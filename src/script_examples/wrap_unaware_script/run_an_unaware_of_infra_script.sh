#!/bin/bash

all_arguments=( "$@" )

rest_of_arguments=( "$@" )

# shellcheck disable=SC1091
. /opt/IAS/lib/bash4/IAS/BashInfra/full_project_lib.sh || exit 1

program_to_run="$(get_bin_dir)/unaware_of_infra_script.sh"

write_log_start "${all_arguments[@]}"

output_file_name=$(get_output_file_name)

program_base_name=$( basename "$program_to_run"  )

pbn_escaped=$(printf '%s\n' "$program_base_name" | sed 's/[\/&]/\\&/g')
write_log_informational "Running: $program_to_run"
command_to_run=(
	stdbuf --error=L --output=L "$program_to_run" \
		"${rest_of_arguments[@]}"
)

write_log_informational "Full command: ${command_to_run[@]}"

"${command_to_run[@]}" \
	> "$output_file_name" \
	2> >( stdbuf --output=L sed "s/^/$pbn_escaped : / " | write_log_informational )

exit_status_of_unaware_script=$?

if [[ $exit_status_of_unaware_script == 0 ]]
then
	write_log_informational "$program_to_run" exited fine.
else
	write_log_error "$program_to_run" failed to run.  Please check logs.
fi

write_log_informational "Wrote: ${output_file_name}"
write_log_informational "Exit status: ${exit_status_of_unaware_script}"

write_log_end

exit $exit_status_of_unaware_script

