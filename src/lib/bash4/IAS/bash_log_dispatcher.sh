#!/bin/bash

if [[ "$LOG_TO_FILE" == "1" ]]; then
	. filelog_lib.sh
else
	. syslog_lib.sh
fi
