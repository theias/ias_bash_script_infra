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

LOG_DEBUG=0
LOGGER_SYSLOG_FACILITY="local3"
LOG_TO_STDERR=0

LOGGER=/usr/bin/logger

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

function write_logger_syslog_message
{
	local log_priority
	local msg

	log_priority="$1"
	msg="$2"
	
	if [[ -z "$msg" ]]
	then
		msg="Empty log message"
	fi
	
	logger_options=( \
		"--tag=$0" \
		'--priority' $log_priority \
		"--id=$$" \
	)
	
	if [[ "$LOG_TO_STDERR" == "1" ]]
	then
		logger_options=('-s' "${logger_options[@]}");
	fi
	"$LOGGER" ${logger_options[@]} "$msg"
	
}

write_log_alert ()
{
	local msg
	msg="$@"
	write_logger_syslog_alert "$msg"
}

write_logger_syslog_alert ()
{
	local msg
	msg="$@"

	write_logger_syslog_message "$LOGGER_SYSLOG_FACILITY.alert" "$msg"
}

write_log_critical ()
{
	local msg
	msg="$@"
	write_logger_syslog_critical "$msg"
}

write_logger_syslog_critical ()
{
	local msg
	msg="$@"

	write_logger_syslog_message "$LOGGER_SYSLOG_FACILITY.crit" "$msg"
}

write_log_debug ()
{
	local msg
	msg="$@"
	write_logger_syslog_debug "$msg"
}

write_logger_syslog_debug ()
{
	local msg
	msg="$@"

	if [[ "$LOG_DEBUG" == "0" ]]
	then
		return
	fi
	
	write_logger_syslog_message "$LOGGER_SYSLOG_FACILITY.debug" "$msg"
}

write_log_emergency ()
{
	local msg
	msg="$@"
	write_logger_syslog_emergency "$msg"
}

write_logger_syslog_emergency ()
{
	local msg
	msg="$@"

	write_logger_syslog_message "$LOGGER_SYSLOG_FACILITY.emerg" "$msg"
}

write_log_error ()
{
	local msg
	msg="$@"
	write_logger_syslog_error "$msg"
}

write_logger_syslog_error ()
{
	local msg
	msg="$@"

	write_logger_syslog_message "$LOGGER_SYSLOG_FACILITY.error" "$msg"
}

write_log_informational ()
{
	local msg
	msg="$@"
	write_logger_syslog_informational "$msg"
}

write_logger_syslog_informational ()
{
	local msg
	msg="$@"

	write_logger_syslog_message "$LOGGER_SYSLOG_FACILITY.info" "$msg"
}

write_log_notice ()
{
	local msg
	msg="$@"
	write_logger_syslog_notice "$msg"
}

write_logger_syslog_notice ()
{
	local msg
	msg="$@"

	write_logger_syslog_message "$LOGGER_SYSLOG_FACILITY.notice" "$msg"
}

write_log_warning ()
{
	local msg
	msg="$@"
	write_logger_syslog_warning "$msg"
}

write_logger_syslog_warning ()
{
	local msg
	msg="$@"

	write_logger_syslog_message "$LOGGER_SYSLOG_FACILITY.warning" "$msg"
}
