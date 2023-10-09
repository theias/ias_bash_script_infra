#!/bin/bash


# By default this will return the home directory of the 
# user of $LOGNAME, which (typically?) corresponds to the
# user of the current process.

# Options for IAS_INFRA_HOME_DIR_TYPE are::
#	"process" - return the home directory of the user that owns the current process
# 	"user" - return the home directory of the user specified in IAS_INFRA_HOME_DIR_USER
#	"owner" - return the home directory of the owner of $0
# 	"path" - return the specified in IAS_INFRA_HOME_DIR_PATH
# 	"path_owner" - return the owner of the path specified in IAS_INFRA_HOME_DIR_PATH


function get_IAS_infra_home_dir_path_owner
{
	local path="$1"
	if [[ -z "$path" ]]
	then
		>&2 printf '%s\n'  \
			"${BASH_SOURCE[0]} : get_IAS_infra_home_dir_path_owner : first parameter is path"
		return 1
	fi

	stat -c '%U' "$path"
	return $?
}

function get_IAS_infra_home_dir_for_user
{
	local user="$1"
	if [[ -z "$user" ]]
	then
		>&2 printf '%s\n' \
			"${BASH_SOURCE[0]} : get_IAS_infra_home_dir_for_user : first parameter is user"
		return 1
	fi
	
	eval printf '%s' "~$user"
}

function get_IAS_infra_home_dir
{

	current_user="$LOGNAME"
	# >&2 printf "Current user: %s\n" "$current_user"

	local wanted_user

	if [[ -z "$IAS_INFRA_HOME_DIR_TYPE" ]]
	then
		get_IAS_infra_home_dir_for_user "$current_user"
		return $?
	
	elif [[ "$IAS_INFRA_HOME_DIR_TYPE" == "process" ]]
	then
		get_IAS_infra_home_dir_for_user "$current_user"
		return $?

	elif [[ "$IAS_INFRA_HOME_DIR_TYPE" == "user" ]]
	then
		get_IAS_infra_home_dir_for_user "$IAS_INFRA_HOME_DIR_USER"
		return $?
	
	elif [[ "$IAS_INFRA_HOME_DIR_TYPE" == "owner" ]]
	then
		wanted_user=$( get_IAS_infra_home_dir_path_owner "$0" )
		get_IAS_infra_home_dir_for_user "$wanted_user"

	elif [[ "$IAS_INFRA_HOME_DIR_TYPE" == "path_owner" ]]
	then
		if [[ -z "$IAS_INFRA_HOME_DIR_PATH" ]]
		then
			>&2 printf "%s\n" "path_owner requires path $IAS_INFRA_HOME_DIR_PATH"
			return 1
		fi

		wanted_user=$( get_IAS_infra_home_dir_path_owner "$IAS_INFRA_HOME_DIR_PATH" )
		get_IAS_infra_home_dir_for_user "$wanted_user"
		return $?
	else
		>&2 printf '%s\n' \
			"get_IAS_infra_home_dir: Unable to figure out what you wanted."
	fi
}
