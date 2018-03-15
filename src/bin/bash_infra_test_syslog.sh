#!/bin/bash

# If you MUST load an environment file:
# ENVIRONMENT_CONFIG_REQUIRED=1
#################################
# Include this for Bash goodness


# NOTE: This runs against the SOURCE TREE version of FindBin...
# LOG_TO_FILE='1'
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -L )"
IAS_BASH_INFRA_LIB_DIR="${SCRIPT_PATH}/../lib/bash4/IAS/BashInfra/"

. $IAS_BASH_INFRA_LIB_DIR/full_project_lib.sh

if [[ ! -d `get_bin_dir` ]]; then
	unfound_bin_dir=`get_bin_dir`
	echo "The directory, '${unfound_bin_dir}' , does not exist"
	exit 1
fi

. ${BASH_FINDBIN_REALBIN}/bash_lib.sh

#################################

write_log_start

output_file_name=`get_output_file_name`

# debug_project_variables
echo "Here is the configuration file example_config.conf:"
cat "`get_conf_dir`"/example_config.conf

write_log_debug "Here is a debug message."

write_log_informational "Wrote: ${output_file_name}"
write_log_informational "Exit status: ${exit_status}"
write_log_error "This is an error."

write_log_end

