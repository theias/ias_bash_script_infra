#!/bin/bash

LOG_ERRORS_TO_STDERR=${LOG_ERRORS_TO_STDERR:-1}

LOG_TO_STDERR_write_log_alert=${LOG_TO_STDERR_write_log_alert:-$LOG_ERRORS_TO_STDERR}
LOG_TO_STDERR_write_log_critical=${LOG_TO_STDERR_write_log_critical:-$LOG_ERRORS_TO_STDERR}
LOG_TO_STDERR_write_log_emergency=${LOG_TO_STDERR_write_log_emergency:-$LOG_ERRORS_TO_STDERR}
LOG_TO_STDERR_write_log_error=${LOG_TO_STDERR_write_log_error:-$LOG_ERRORS_TO_STDERR}
LOG_TO_STDERR_write_log_warning=${LOG_TO_STDERR_write_log_warning:-$LOG_ERRORS_TO_STDERR}

LOG_TO_STDERR_write_log_debug=${LOG_TO_STDERR_write_log_debug:-0}
LOG_TO_STDERR_write_log_informational=${LOG_TO_STDERR_write_log_informational:-0}
LOG_TO_STDERR_write_log_notice=${LOG_TO_STDERR_write_log_notice:-0}

if [[ "$LOG_TO_FILE" == "1" ]]; then
	# shellcheck disable=SC1090
	. "${IAS_BASH_INFRA_LIB_DIR}/filelog_lib.sh"
else
	# shellcheck disable=SC1090
	. "${IAS_BASH_INFRA_LIB_DIR}/syslog_lib.sh"
fi
