#!/bin/bash

SCRIPT_PATH="$0"
SCRIPT_ARGS="$@"

if [[ "$SCRIPT_PATH" == "-bash" ]]; then
	export SCRIPT_PATH=`echo "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}"`
fi

# echo "SCRIPT_PATH: " $SCRIPT_PATH

BIN_DIR="$BIN_DIR"
if [[ -z "$BIN_DIR" ]]; then
	if [[ -z "$BASH_FINDBIN_REALBIN" ]]; then
		BIN_DIR="$( cd "$(dirname -- "$SCRIPT_PATH")" ; pwd )"
	else
		BIN_DIR="$BASH_FINDBIN_REALBIN"
	fi
fi

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


if [ -d "$BIN_DIR/../../src" ]; then
	PROJECT_DIRECTORY="$( cd "$(dirname "$BIN_DIR/../../../")" ; pwd -L )"
	PROJECT_NAME=`basename "$PROJECT_DIRECTORY"`
	# echo "Project directory: $PROJECT_DIRECTORY"
	# echo "PROJECT_NAME: $PROJECT_NAME"
	PACKAGE_NAME=`echo "$PROJECT_NAME" | sed 's/_/-/g'`
	# echo "Package name: $PACKAGE_NAME"
	
	OUTPUT_DIR="$BIN_DIR"/../output
	INPUT_DIR="$BIN_DIR"/../input
	CONF_DIR="$BIN_DIR"/../etc
	LOG_DIR="$BIN_DIR"/../log
else
	PACKAGE_NAME=`basename $BIN_DIR`
	
	OUTPUT_DIR="$BIN_DIR"/../../output/"$PACKAGE_NAME"
	INPUT_DIR="$BIN_DIR"/../../input/"$PACKAGE_NAME"
	CONF_DIR="$BIN_DIR"/../../etc/"$PACKAGE_NAME"
	LOG_DIR="$BIN_DIR"/../../log/"$PACKAGE_NAME"
fi


LOG_FILE_PATH="${LOG_DIR}/${SCRIPT_NAME}.log"

if [[ ! -f "$CONF_DIR"/environment.sh ]]; then
	if [[ ! -z ${ENVIRONMENT_CONFIG_REQUIRED+x} ]]; then
		>&2 echo "ERROR: $CONF_DIR/environment.sh doesn't exist."
		>&2 echo "It should contain either:"
		>&2 echo "ENVIRONMENT='PROD'"
		>&2 echo "or"
		>&2 echo "ENVIORNMENT='DEV'"
		exit 1
	fi
else
	. "$CONF_DIR"/environment.sh
fi

function debug_variables
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

function get_output_file_name
{
	local output_file_date
	local remainder

	remainder="$1"

	if [[ ! -n "$remainder" ]]; then
		remainder='generic.txt'
	fi
	
	output_file_date=$( $DATE "+%Y-%m-%d-%H-%M-%S" )

	local full_output_dir
	full_output_dir="$OUTPUT_DIR/$SCRIPT_NAME"

	if mkdir -p "$full_output_dir"; then
		: #noop
	else
		>&2  echo "Unable to mkdir -p $full_output_dir"
		exit 1
	fi

	echo "${full_output_dir}/${output_file_date}--${SCRIPT_NAME}--${remainder}"
}

function write_error
{
	>&2 echo "$@"
	write_log_error "$@"
}

function write_log_start
{
	write_log_informational "$SCRIPT_PATH" "$script_args" $USER $$ --BEGINNING--
}

function write_log_end
{
	write_log_informational $$ --ENDING--
}



