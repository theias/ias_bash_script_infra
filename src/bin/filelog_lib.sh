#!/bin/bash


#	Please see man syslog for more information.
# LOG_TO_STDERR - log messages to STDERR

LOG_DEBUG=0
LOG_TO_STDERR=0

$LOG_FILE_PATH="$LOG_FILE_PATH"
if [[ -z "$LOG_FILE_PATH" ]]; then
	local SCRIPT_FILE=$(basename "$SCRIPT_PATH")
	local SCRIPT_NAME="${SCRIPT_FILE%.*}"
	LOG_FILE_PATH="/tmp/${SCRIPT_NAME}.log"

	>&2 echo "LOG_FILE_PATH not set.  Logging to $LOG_FILE_PATH"
fi

# echo "SCRIPT_PATH: " $SCRIPT_PATH

function write_logfile_message
{
	local log_priority
	local msg

	log_priority="$1"
	msg="$2"
	
	if [[ -z "$msg" ]]
	then
		msg="Empty log message"
	fi
	
	if [[ "$LOG_TO_STDERR" == "1" ]]
	then
		>&2 echo "$msg"
	fi
	echo `date` `hostname` $0"[$$]" $log_priority "$msg" >> $LOG_FILE_PATH
	
}

write_log_alert ()
{
	local msg
	msg="$@"
	write_logfile_alert "$msg"
}

write_logfile_alert ()
{
	local msg
	msg="$@"

	write_logfile_message "alert" "$msg"
}

write_log_critical ()
{
	local msg
	msg="$@"
	write_logfile_critical "$msg"
}

write_logfile_critical ()
{
	local msg
	msg="$@"

	write_logfile_message "crit" "$msg"
}

write_log_debug ()
{
	local msg
	msg="$@"
	write_logfile_debug "$msg"
}

write_logfile_debug ()
{
	local msg
	msg="$@"

	if [[ "$LOG_DEBUG" == "0" ]]
	then
		return
	fi
	
	write_logfile_message "debug" "$msg"
}

write_log_emergency ()
{
	local msg
	msg="$@"
	write_logfile_emergency "$msg"
}

write_logfile_emergency ()
{
	local msg
	msg="$@"

	write_logfile_message "emerg" "$msg"
}

write_log_error ()
{
	local msg
	msg="$@"
	write_logfile_error "$msg"
}

write_logfile_error ()
{
	local msg
	msg="$@"

	write_logfile_message "error" "$msg"
}

write_log_informational ()
{
	local msg
	msg="$@"
	write_logfile_informational "$msg"
}

write_logfile_informational ()
{
	local msg
	msg="$@"

	write_logfile_message "info" "$msg"
}

write_log_notice ()
{
	local msg
	msg="$@"
	write_logfile_notice "$msg"
}

write_logfile_notice ()
{
	local msg
	msg="$@"

	write_logfile_message "notice" "$msg"
}

write_log_warning ()
{
	local msg
	msg="$@"
	write_logfile_warning "$msg"
}

write_logfile_warning ()
{
	local msg
	msg="$@"

	write_logfile_message "warning" "$msg"
}
