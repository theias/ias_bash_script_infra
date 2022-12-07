#!/bin/bash

LOG_TO_FILE=${LOG_TO_FILE:-0}

# shellcheck disable=SC2164
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -L )"
IAS_BASH_INFRA_LIB_DIR="${SCRIPT_PATH}/../lib/bash4/IAS/BashInfra/"

# shellcheck disable=SC1090
. "$IAS_BASH_INFRA_LIB_DIR/full_project_lib.sh" || exit 1
# shellcheck disable=SC1090
. "${BASH_FINDBIN_REALBIN}/bash_lib.sh" || exit 1

function make_some_output_and_stderr
{
	for i in {1..5}
	do
		>&2 echo "Stderr: $i"
		echo "Stdout: $i"
	done
}

write_log_start

output_file_name=$(get_output_file_name)

# debug_project_variables
echo "Here is the configuration file example_config.conf:"
cat "$(get_conf_dir)/example_config.conf"

write_log_debug "Here is a debug message."

write_log_informational "Wrote: ${output_file_name}"

make_some_output_and_stderr | write_log_informational

exit_status=0
write_log_informational "Exit status: ${exit_status}"
write_log_error "This is an error."

write_log_end
exit $exit_status
