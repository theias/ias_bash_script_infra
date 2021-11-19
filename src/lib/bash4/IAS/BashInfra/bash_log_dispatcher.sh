#!/bin/bash

if [[ "$LOG_TO_FILE" == "1" ]]; then
	. "${IAS_BASH_INFRA_LIB_DIR}/filelog_lib.sh"
else
	. "${IAS_BASH_INFRA_LIB_DIR}/syslog_lib.sh"
fi
