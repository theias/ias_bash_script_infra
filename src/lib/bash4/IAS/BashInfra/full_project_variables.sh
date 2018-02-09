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
