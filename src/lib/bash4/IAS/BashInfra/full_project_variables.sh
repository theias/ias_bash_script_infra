#!/bin/bash

function debug_project_variables
{
	echo "USER: ${USER}"
	echo "HOME: ${HOME}"
	echo "Bin dir: $BIN_DIR"
	echo "Environment: $ENVIRONMENT"
	echo "Script path: $BIN_DIR"
	echo "Package name: $PACKAGE_NAME"
	echo "Output dir: $OUTPUT_DIR"
	echo "Input dir: $INPUT_DIR"
	echo "Conf dir: $CONF_DIR"
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



