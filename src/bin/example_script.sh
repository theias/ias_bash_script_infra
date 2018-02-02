#!/bin/bash

# If you MUST load an environment file:
# ENVIRONMENT_CONFIG_REQUIRED=1
#################################
# Include this for Bash goodness

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -L )"

. $SCRIPT_PATH/syslog_lib.sh

. $SCRIPT_PATH/bash_lib.sh

if [[ ! -d $BIN_DIR ]]; then
	echo "I was unable to find BIN_DIR : $BIN_DIR .  Please check bash_lib.sh"
	exit 1
fi

#################################

write_log_start

output_file_name=`get_output_file_name`

debug_variables
echo "Here is the configuration file example_config.conf:"
cat $CONF_DIR/example_config.conf

write_log_informational "Wrote: ${output_file_name}"
write_log_informational "Exit status: ${exit_status}"

write_log_end

