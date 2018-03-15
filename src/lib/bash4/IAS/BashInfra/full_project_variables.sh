#!/bin/bash

function get_script_name
{
	echo $SCRIPT_NAME
}

function debug_project_variables
{
	# TODO: These need to be corrected.
	echo "USER: ${USER}"
	echo "HOME: ${HOME}"
	echo "Bin dir: " `get_bin_dir`
	echo "Environment: $ENVIRONMENT"
	echo "Package name: $PACKAGE_NAME"
	echo "Script file: " $SCRIPT_FILE
	echo "Script name: " $SCRIPT_NAME
	echo "Script extension: "$SCRIPT_EXTENSION
}

function debug_project_paths
{
	debug_project_variables
}

SCRIPT_PATH="$0"
if [[ "$SCRIPT_PATH" == "-bash" ]]; then
	SCRIPT_PATH=`echo "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}"`
fi

SCRIPT_ARGS="$@"

SCRIPT_FILE=$(basename "$SCRIPT_PATH")
SCRIPT_EXTENSION="${SCRIPT_FILE##*.}"
SCRIPT_NAME="${SCRIPT_FILE%.*}"

GETENT=/usr/bin/getent
DATE=/bin/date

USER="$USER"
if [[ ! -z ${USER+x} ]]; then
	USER="$LOGNAME"
fi

HOME="$HOME"
if [[ ! -z ${HOME+x} ]]; then
	HOME=`$GETENT passwd -- "$USER" | awk -F ':' '{print $6}'`
fi



