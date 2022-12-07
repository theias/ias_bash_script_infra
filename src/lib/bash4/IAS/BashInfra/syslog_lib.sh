#!/bin/bash

# This script provides an interface to writing log messages to syslog.
# The subroutines and severity levels are:
#	write_log_alert()
#	write_log_critical()
#	write_log_debug()
#	write_log_emergency()
#	write_log_error()
#	write_log_informational()
#	write_log_notice()
#	write_log_warning()
#
# Variables
# LOG_DEBUG - (0,1) - print debug messages
# LOGGER_SYSLOG_FACILITY - what logging facility to use.
#	Defaults to "local3"
#	Please see man syslog for more information.
# LOG_TO_STDERR - log messages to STDERR
# LOG_ERRORS_TO_STDERR - log error messages to standard error

LOGGER_SYSLOG_FACILITY=${LOGGER_SYSLOG_FACILITY:-local3}

LOGGER=${LOGGER:-/usr/bin/logger}

if [ -z ${LOG_ERRORS_TO_STDERR+x} ]
then
	LOG_ERRORS_TO_STDERR=1
fi

# Everything after this point is used for development purposes

# Level
# emergency - emerg
# alert - alert
# critical - crit
# error - err, error
# warning - warning, warn
# notice - notice
# informational - info
# debug - debug

# Facilities
# local0
# local1
# local2
# local3
# local4
# local5
# local6
# local7

function check_logging_setup
{
	:
	# echo "blank for now."
}

function write_logger_syslog_message
{
	local log_priority="$1" ; shift
	local log_to_stderr="$1" ; shift
	local msg="$*" 

	logger_options=( \
		"--tag=$0[$$]" \
		'--priority' "$log_priority" \
#		"--id=$$" \
	)
	# shellcheck disable=SC2153
	if [[ "$LOG_TO_STDERR" == "1" || "$log_to_stderr" == "1" ]]
	then
		logger_options=('-s' "${logger_options[@]}");
	fi

	#  echo "Command:" "$LOGGER" "${logger_options[@]}" "$msg"
	if [[ -z "$msg" ]]
	then
		"$LOGGER" "${logger_options[@]}"
	else
		"$LOGGER" "${logger_options[@]}" "$msg"
	fi
	
	
}

write_log_alert ()
{
	local msg
	msg="$*"
	write_logger_syslog_alert "$msg"
}

write_logger_syslog_alert ()
{
	local msg
	msg="$*"

	write_logger_syslog_message \
		"$LOGGER_SYSLOG_FACILITY.alert" \
		"$LOG_TO_STDERR_write_log_alert" \
		"$msg"
}

write_log_critical ()
{
	local msg
	msg="$*"
	write_logger_syslog_critical "$msg"
}

write_logger_syslog_critical ()
{
	local msg
	msg="$*"

	write_logger_syslog_message \
		"$LOGGER_SYSLOG_FACILITY.crit" \
		"$LOG_TO_STDERR_write_log_critical" \
		"$msg"
}

write_log_debug ()
{
	local msg
	msg="$*"
	write_logger_syslog_debug 0 "$msg"
}

write_logger_syslog_debug ()
{
	local msg
	msg="$*"

	if [[ "$LOG_DEBUG" == "1" ]]
	then
		write_logger_syslog_message \
			"$LOGGER_SYSLOG_FACILITY.debug" \
			"$LOG_TO_STDERR_write_log_debug" \
			"$msg"
	fi
}

write_log_emergency ()
{
	local msg
	msg="$*"
	write_logger_syslog_emergency "$msg"
}

write_logger_syslog_emergency ()
{
	local msg
	msg="$*"

	write_logger_syslog_message \
		"$LOGGER_SYSLOG_FACILITY.emerg" \
		"$LOG_TO_STDERR_write_log_emergency" \
		"$msg"
}

write_log_error ()
{
	local msg
	msg="$*"
	write_logger_syslog_error "$msg"
}

write_logger_syslog_error ()
{
	local msg
	msg="$*"

	write_logger_syslog_message "$LOGGER_SYSLOG_FACILITY.error" \
		"$LOG_TO_STDERR_write_log_error" \
		"$msg"
}

write_log_informational ()
{
	local msg
	msg="$*"
	write_logger_syslog_informational "$msg"
}

write_logger_syslog_informational ()
{
	local msg
	msg="$*"

	write_logger_syslog_message \
		"$LOGGER_SYSLOG_FACILITY.info" \
		"$LOG_TO_STDERR_write_log_informational" \
		"$msg"
}

write_log_notice ()
{
	local msg
	msg="$*"
	write_logger_syslog_notice "$msg"
}

write_logger_syslog_notice ()
{
	local msg
	msg="$*"

	write_logger_syslog_message \
		"$LOGGER_SYSLOG_FACILITY.notice" \
		"$LOG_TO_STDERR_write_log_notice" \
		"$msg"
}

write_log_warning ()
{
	local msg
	msg="$*"
	write_logger_syslog_warning "$msg"
}

write_logger_syslog_warning ()
{
	local msg
	msg="$*"

	write_logger_syslog_message \
		"$LOGGER_SYSLOG_FACILITY.warning" \
		"$LOG_TO_STDERR_write_log_warning" \
		"$msg"
}
