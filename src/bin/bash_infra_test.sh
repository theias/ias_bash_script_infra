#!/bin/bash

# If you MUST load an environment file:
# ENVIRONMENT_CONFIG_REQUIRED=1
#################################
# Include this for Bash goodness


# NOTE: This runs against the SOURCE TREE version of FindBin...
LOG_TO_FILE='1'
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -L )"
IAS_BASH_INFRA_LIB_DIR="${SCRIPT_PATH}/../lib/bash4/IAS/BashInfra/"

. $IAS_BASH_INFRA_LIB_DIR/full_project_lib.sh

if [[ ! -d $BIN_DIR ]]; then
	echo "I was unable to find BIN_DIR : $BIN_DIR .  Please check bash_lib.sh"
	exit 1
fi

. ${BASH_FINDBIN_REALBIN}/bash_lib.sh

#################################

write_log_start

output_file_name=`get_output_file_name`

debug_project_variables
echo "Here is the configuration file example_config.conf:"
cat $CONF_DIR/example_config.conf

write_log_informational "Wrote: ${output_file_name}"
write_log_informational "Exit status: ${exit_status}"

write_log_end

