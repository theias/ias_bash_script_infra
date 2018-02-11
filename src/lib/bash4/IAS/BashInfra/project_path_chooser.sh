function set_project_chosen_bin
{
	local wanted
	wanted="$1"
	
	if [[ "$wanted" == "REALBIN" ]]; then
		PROJECT_CHOSEN_BIN="REALBIN"
		PROJECT_BIN_DIR="$BASH_FINDBIN_REALBIN"
		return
	elif [[ "$wanted" == "BIN" ]]; then
		PROJECT_CHOSEN_BIN="BIN"
		PROJECT_BIN_DIR="$BASH_FINDBIN_BIN"
		return
	else
		>&2 echo "$wanted is NOT a valid type of chosen bin."
		exit 1
	fi
	return
}

function get_project_whence
{
	echo "$PROJECT_BIN_DIR"
}

PROJECT_BIN_DIR="$PROJECT_BIN_DIR"
PROJECT_CHOSEN_BIN="$PROJECT_CHOSEN_BIN"
if [[ -z "$PROJECT_BIN_DIR" ]]; then
	if [[ ! -z ${PROJECT_CHOSEN_BIN+x} ]]; then
		PROJECT_CHOSEN_BIN='REALBIN'
	fi
	
	set_project_chosen_bin "${PROJECT_CHOSEN_BIN}"

fi


