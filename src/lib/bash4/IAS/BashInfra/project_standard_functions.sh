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
	local output_dir=`get_output_dir`
	full_output_dir="$output_dir/$SCRIPT_NAME"

	if mkdir -p "$full_output_dir"; then
		: #noop
	else
		>&2  echo "Unable to mkdir -p $full_output_dir"
		exit 1
	fi

	echo "${full_output_dir}/${output_file_date}--${SCRIPT_NAME}--${remainder}"
}

function get_log_file_path
{
	local log_dir=`get_log_dir`
	echo `${log_dir}/${SCRIPT_NAME}.log`
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

function project_is_bin_dir_in_src
{
	# TODO: This must be changed to test if the second-to-last
	# component in the path to the bin dir is src; not that 2
	# levels up src exists...
	local some_bin_dir=`get_project_whence`
	some_bin_dir="$1"
	# >&2 echo "SOME BIN DIR: $some_bin_dir"
	
	if [ -d "$some_bin_dir/../../src" ]; then
		>&2 echo "GOT HERE"
		return 0
	fi
	return 1
}



