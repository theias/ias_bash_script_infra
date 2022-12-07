#!/bin/bash


#	Please see man syslog for more information.
# LOG_TO_STDERR - log messages to STDERR
# LOG_DEBUG - log debug messages

# TODO : LOG_ERRORS_TO_STD_ERROR

LOG_FILE_PATH="$LOG_FILE_PATH"
if [[ -z "$LOG_FILE_PATH" ]]; then
	LOG_FILE_PATH=$(get_log_file_path)
fi

# echo "SCRIPT_PATH: " $SCRIPT_PATH

function check_logging_setup
{
	if [[ ! -d "$(dirname "${LOG_FILE_PATH}")" ]]; then
		>&2 echo "WARNING: dirname of ${LOG_FILE_PATH} does not exist!"
	fi
}

function write_logfile_message
{
	local log_priority="$1" ; shift
	local log_to_stderr="$1" ; shift
	local msg="$1"
	
	local log_message_prepend="$(date) $(hostname) $0 [$$] $log_priority:"

	if [[ -z "$msg" ]]
	then
		# This appears to be OK for the log message prepend escaping to be sent to sed
		local escaped_prepend=$(printf '%s\n' "$log_message_prepend" | sed 's/[\/&]/\\&/g')
#		# local escaped_prepend=$( sed 's/[^^]/[&]/g; s/\^/\\^/g' <<< $log_message_prepend )

		if [[ "$LOG_TO_STDERR" == "1" || "$log_to_stderr" == "1" ]]
		then
			cat | sed "s/^/$escaped_prepend /" | tee >(cat 1>&2)  >> "$LOG_FILE_PATH" 
		else
			cat | sed "s/^/$escaped_prepend /" >> "$LOG_FILE_PATH"
		fi
	else	
		if [[ "$LOG_TO_STDERR" == "1" || "$log_to_stderr" == "1" ]]
		then
			>&2 echo "$msg"
		fi
		echo "$log_message_prepend" "$msg" >> "$LOG_FILE_PATH"
	fi
}

function write_log_alert
{
	local msg
	msg="$*"
	write_logfile_alert "$msg"
}

function write_logfile_alert
{
	local msg
	msg="$*"

	write_logfile_message \
		"alert" \
		"$LOG_TO_STDERR_write_log_alert" \
		"$msg"
}

function write_log_critical
{
	local msg
	msg="$*"
	write_logfile_critical "$msg"
}

function write_logfile_critical
{
	local msg
	msg="$*"

	write_logfile_message \
		"crit" \
		"$LOG_TO_STDERR_write_log_critical" \
		"$msg"
}

function write_log_debug
{
	local msg
	msg="$*"
	write_logfile_debug "$msg"
}

function write_logfile_debug
{
	local msg
	msg="$*"

	if [[ "$LOG_DEBUG" == "1" ]]
	then
		write_logfile_message \
			"debug" \
			"$LOG_TO_STDERR_write_log_debug" \
			"$msg"
	fi
	
}

function write_log_emergency
{
	local msg
	msg="$*"
	write_logfile_emergency "$msg"
}

function write_logfile_emergency
{
	local msg
	msg="$*"

	write_logfile_message \
		"emerg" \
		"$LOG_TO_STDERR_write_log_emergency" \
		"$msg"
}

function write_log_error
{
	local msg
	msg="$*"
	write_logfile_error "$msg"
}

function write_logfile_error
{
	local msg
	msg="$*"

	write_logfile_message \
		"error" \
		"$LOG_TO_STDERR_write_log_error" \
		"$msg"
}

function write_log_informational
{
	local msg
	msg="$*"
	write_logfile_informational "$msg"
}

function write_logfile_informational
{
	local msg
	msg="$*"

	write_logfile_message \
		"info" \
		"$LOG_TO_STDERR_write_log_informational" \
		"$msg"
}

function write_log_notice
{
	local msg
	msg="$*"
	write_logfile_notice "$msg"
}

function write_logfile_notice
{
	local msg
	msg="$*"

	write_logfile_message \
		"notice" \
		"$LOG_TO_STDERR_write_log_notice" \
		"$msg"
}

function write_log_warning
{
	local msg
	msg="$*"
	write_logfile_warning "$msg"
}

function write_logfile_warning
{
	local msg
	msg="$*"

	write_logfile_message \
		"warning" \
		"$LOG_TO_STDERR_write_log_warning" \
		"$msg"
}
