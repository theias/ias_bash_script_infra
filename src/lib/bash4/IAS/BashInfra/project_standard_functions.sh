#!/bin/bash

function get_output_file_name
{
	local output_file_date
	local remainder

	remainder="$1"

	if [[ -z "$remainder" ]]; then
		remainder='generic.txt'
	fi
	
	output_file_date=$( date "+%Y-%m-%d-%H-%M-%S" )

	local full_output_dir
	local output_dir=$(get_output_dir)
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
	local log_dir=$(get_log_dir)
	echo "${log_dir}/${SCRIPT_NAME}.log"
}

function write_error
{
	>&2 echo "$@"
	write_log_error "$@"
}

function write_log_start
{
	write_log_informational "$SCRIPT_PATH" "$*" "$USER" "$$" "--BEGINNING--"
}

function write_log_end
{
	write_log_informational $$ --ENDING--
}

function project_is_bin_dir_in_src
{
	# Returns true if a path ends with src/something
	local dir_arg="$1"
	# echo "Passed: $dir_arg"
	local dir="${dir_arg:-`get_project_whence`}"
	# echo "Examaning: $dir"

	dir=$(dirname "$dir")
	dir=$(basename "$dir")

	if [[ "$dir" = "src" ]]
	then
		return 0
	fi
	return 1
}

function dump_output_log_file
{
	local output_log_file="$1"
	
	if [[ -s "$output_log_file" ]]; then
		write_log_informational "Output log follows."
		write_log_informational "******** BEGIN OUTPUT LOG ********"
		cat "$output_log_file" | while read i
		do
			write_log_informational "$i"
		done
		write_log_informational "******** END OUTPUT LOG ********"
	fi

	rm "$output_log_file"
}

function dump_error_log_file
{
	local error_log_file="$1"
	
	if [[ ! -e "$error_log_file" ]]
	then
		write_log_error "Told to dumpe_error_log_file on non-existent file."
		return
	fi
	
	if [[ -s "$error_log_file" ]]; then
		write_log_error "Error log follows."
		write_log_error "******** BEGIN ERROR LOG ********"
		cat "$error_log_file" | while read i
		do
			write_log_error "$i"
		done
		write_log_error "******** END ERROR LOG ********"
	fi

	rm "$error_log_file"
}

function get_somebodys_attention
{
	write_log_error "$@"
}

function attention_if_fewer_lines
{
	local file_name="$1"
	local min_lines="$2"
	local line_count

	line_count=$(wc -l "$file_name" | awk '{print $1}')


	if (( line_count < min_lines )); then
		get_somebodys_attention "${file_name} has less than ${min_lines} lines"
		return 0
	fi
	return 1
}

function get_newest_file_in_dir
{
	local dir
	dir="$1"

	if ! [[ -d "$dir" ]]; then
		>&2 echo "$dir" not a directory
		return
	fi

	local latest
	for f in "$dir"/*; do
		[[ -f $f ]] || continue
		[[ $f -nt $latest ]] && latest=$f
	done

	if [[ -z "$latest" ]]; then
		return
	fi
	echo "$latest"
	return
}

function append_all_newest_files_in_dir
{
	local output_file
	local dir

	output_file="$1"
	dir="$2"

	if ! [[ -d "$dir" ]]; then
		>&2 printf "%s is not a directory" "$dir"
	fi

	find -H "$dir"/* -type d -print0 | while IFS= read -r -d '' i
	do
		file_name=$(get_newest_file_in_dir "$i")
		write_log_informational "Adding: $file_name"
		# echo "file: " $file_name
		if [[ "$file_name" == *.gz ]]; then
			gunzip -c -- "$file_name" >> "$output_file"
		else
			cat -- "$file_name" >> "$output_file"
		fi
		
	done
}

