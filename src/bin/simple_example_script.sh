#!/bin/bash

all_arguments=( $@ )

# If you MUST load an environment file:
# ENVIRONMENT_CONFIG_REQUIRED=1
#################################
# Include this for Bash goodness

. /opt/IAS/lib/bash4/IAS/BashInfra/full_project_lib.sh

if [[ ! -d `get_project_whence` ]]; then
	echo "I was unable to find my whence dir.  Please check bash_lib.sh"
	exit 1
fi

#################################

# Note:  Your package installer *should* automatically create the log directory
# for you.  This is here for testing purposes.
# mkdir -p `get_log_dir`

write_log_start
write_log_informational "Arguments: ${all_arguments[@]}"

output_file_name=`get_output_file_name`

echo "Here is the configuration file example_config.conf:"
cat `get_conf_dir`/example_config.conf

date >> "$output_file_name"

write_log_debug "Here is a debug message."
write_log_informational "Wrote: ${output_file_name}"
write_log_informational "Exit status: ${exit_status}"
write_log_error "This is an error."

write_log_end

