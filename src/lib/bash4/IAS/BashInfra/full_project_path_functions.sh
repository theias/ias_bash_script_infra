#!/bin/bash

FULL_PROJECT_INSTALLED_UP_PATHS='../../'

function get_full_project_generic_dir
{
	local some_bin_dir
	local dir_name
	some_bin_dir=`get_project_whence`
	dir_name="$1"
	
	if full_project_is_bin_dir_in_src $some_bin_dir ; then
		echo "${some_bin_dir}/../$dir_name"
		# >&2 echo "We are in src."
		return
	else
		local package_name
		package_name=`get_full_project_package_name "$some_bin_dir"`
		echo "${some_bin_dir}/$FULL_PROJECT_INSTALLED_UP_PATHS/${dir_name}/${package_name}"
		# >&2 echo "We are installed."
		return
	fi
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
	local some_bin_dir
	some_bin_dir=`get_project_whence`
	
	if full_project_is_bin_dir_in_src $some_bin_dir ; then
		echo "${some_bin_dir}/../lib"
		return
	else
		echo "${LIB_INST_DIR}"
	return
}
