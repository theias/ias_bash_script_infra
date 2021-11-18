#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -L )"
IAS_BASH_INFRA_LIB_DIR="${SCRIPT_PATH}/../lib/bash4/IAS/BashInfra/"

. "$IAS_BASH_INFRA_LIB_DIR/full_project_lib.sh" || exit 1
. "${BASH_FINDBIN_REALBIN}/bash_lib.sh" || exit 1

write_log_start

output_file_name=$(get_output_file_name)

# debug_project_variables
echo "Here is the configuration file example_config.conf:"
cat "$(get_conf_dir)/example_config.conf"

write_log_debug "Here is a debug message."

write_log_informational "Wrote: ${output_file_name}"

exit_status=0
write_log_informational "Exit status: ${exit_status}"
write_log_error "This is an error."

write_log_end
exit $exit_status
