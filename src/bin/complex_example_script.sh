#!/bin/bash

all_arguments=( "$@" )

# How to log to files instead.
# Will log to ../log/(somewhere); mkdir the directory
# and logging to files will work.
LOG_TO_FILE='1'

. /opt/IAS/lib/bash4/IAS/BashInfra/full_project_lib.sh || exit 1

# If you have subroutines you abstracted to a file called
# bash_lib.sh, here's how you'd load them:
. "${BASH_FINDBIN_REALBIN}/bash_lib.sh" || exit 1

#################################

# Note:  Your package installer *should* automatically create the log directory
# for you.
mkdir -p "$(get_log_dir)" || exit 1

write_log_start "${all_arguments[@]}"

output_file_name=$(get_output_file_name)

echo "Here is the configuration file example_config.conf:"
cat "$(get_conf_dir)/example_config.conf"

write_log_debug "Here is a debug message."
write_log_informational "Wrote: ${output_file_name}"

exit_status=0
write_log_informational "Exit status: ${exit_status}"
write_log_error "This is an example error."

write_log_end

