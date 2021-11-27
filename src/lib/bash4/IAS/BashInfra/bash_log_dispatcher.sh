#!/bin/bash

if [[ "$LOG_TO_FILE" == "1" ]]; then
	# shellcheck disable=SC1090
	. "${IAS_BASH_INFRA_LIB_DIR}/filelog_lib.sh"
else
	# shellcheck disable=SC1090
	. "${IAS_BASH_INFRA_LIB_DIR}/syslog_lib.sh"
fi
