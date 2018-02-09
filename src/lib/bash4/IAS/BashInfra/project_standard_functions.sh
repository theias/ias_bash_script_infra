#!/bin/bash

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

