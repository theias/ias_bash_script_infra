#!/bin/bash

all_arguments=( "$@" )

# shellcheck disable=SC1091
. /opt/IAS/lib/bash4/IAS/BashInfra/full_project_lib.sh || exit 1

write_log_start "${all_arguments[@]}"

output_file_name=$(get_output_file_name)

echo "Here is the configuration file example_config.conf:"
cat "$(get_conf_dir)/example_config.conf"

date >> "$output_file_name"

write_log_debug "Here is a debug message."
write_log_informational "Wrote: ${output_file_name}"
exit_status=0
write_log_informational "Exit status: ${exit_status}"
write_log_error "This is an example error."

write_log_end

