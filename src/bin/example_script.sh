#!/bin/bash

# If you MUST load an environment file:
# ENVIRONMENT_CONFIG_REQUIRED=1
#################################
# Include this for Bash goodness


# NOTE: This runs against the INSTALLED version of FindBin...
LOG_TO_FILE='1'
. /opt/IAS/lib/bash4/IAS/BashInfra/full_project_lib.sh

if [[ ! -d `get_project_whence` ]]; then
	echo "I was unable to find my whence dir.  Please check bash_lib.sh"
	exit 1
fi

. ${BASH_FINDBIN_REALBIN}/bash_lib.sh

#################################

write_log_start

output_file_name=`get_output_file_name`

echo "Here is the configuration file example_config.conf:"
cat `get_conf_dir`/example_config.conf

write_log_informational "Wrote: ${output_file_name}"
write_log_informational "Exit status: ${exit_status}"

write_log_end

