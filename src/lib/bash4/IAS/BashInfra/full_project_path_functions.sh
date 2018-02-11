#!/bin/bash

FULL_PROJECT_INSTALLED_UP_PATHS='../../'

function get_project_package_name
{
	local some_bin_dir
	some_bin_dir=`get_project_whence`

	if project_is_bin_dir_in_src $some_bin_dir ; then

		local PROJECT_DIRECTORY="$( cd "$(dirname "$BIN_DIR/../../../")" ; pwd -L )"
		local PROJECT_NAME=`basename "$PROJECT_DIRECTORY"`
		# echo "Project directory: $PROJECT_DIRECTORY"
		# echo "PROJECT_NAME: $PROJECT_NAME"
		local PACKAGE_NAME=`echo "$PROJECT_NAME" | sed 's/_/-/g'`
		# echo "Package name: $PACKAGE_NAME"
		echo "${PACKAGE_NAME}"
		return
	else
		local PACKAGE_NAME=`basename "${some_bin_dir}"`
		echo "${PACKAGE_NAME}"
		return
	fi

	
}

function get_full_project_generic_dir
{
	local some_bin_dir
	local dir_name
	some_bin_dir=`get_project_whence`
	dir_name="$1"
	
	if project_is_bin_dir_in_src $some_bin_dir ; then
		echo "${some_bin_dir}/../$dir_name"
		# >&2 echo "We are in src."
		return
	else
		local package_name
		package_name=`get_project_package_name "$some_bin_dir"`
		echo "${some_bin_dir}/$FULL_PROJECT_INSTALLED_UP_PATHS/${dir_name}/${package_name}"
		# >&2 echo "We are installed."
		return
	fi
}

function get_bin_dir
{
	echo `get_project_whence`
}

function get_input_dir
{
	echo `get_full_project_generic_dir input`
}

function get_output_dir
{
	echo `get_full_project_generic_dir output`
}

function get_conf_dir
{
	echo `get_full_project_generic_dir etc`
}

function get_log_dir
{
	echo `get_full_project_generic_dir log`
}

function get_lib_dir
{
	echo `get_full_project_generic_dir lib`	
}

function get_template_dir
{
	echo `get_full_project_generic_dir templates`
}
