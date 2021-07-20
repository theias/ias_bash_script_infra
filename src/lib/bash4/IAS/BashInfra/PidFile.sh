# Simple pidfile functionality

# Returns a pidfile name based off of the name of the script.
# First parameter (optional) is directory for the pidfile
function get_pidfile_name
{
	# echo "In fuction: $BASH_SOURCE"
	# echo "Dollar zero: $0"

	pidfile_dir=${pidfile_dir:-/tmp}

	local file_without_extension=$(basename "$0")
	file_without_extension="${file_without_extension%.*}"
	local pidfile_name="$pidfile_dir/${file_without_extension}.pid"

	echo $pidfile_name
}

# Checks if a process is killable by sending a kill 0 to the
# process ID of the process.
function is_process_killable
{
	local pid="$1"
	if [[ -z "$pid" ]]
	then
		>&2 echo "In is_process_alive no pid given."
		return 1
	fi

	# echo "Checking for alive process: $pid"	
	if kill -0 $pid > /dev/null 2>&1
	then
		return 0
	fi
	return 1
}

# Returns the pid from the pidfile.
# Currently the pidfile format contains one line, and
# that line is the pidfile.  As simple as it is, this means
# we can store more information in the pid file after the first
# line (if we really wanted to...)
function get_pid_from_pidfile
{
	local pidfile="$1"; shift;
	head -n1 "$pidfile"
}
	
function init_pid_file
{
	# Parameters:
	# pidfile [ minutes ]
	#
	# $minutes can be a real value (e.g. 0.2)
	# Desired behavior:
	# If the pid specified in pidfile is running, then it returns 1
	# If:
	#	minutes specified
	# 	and the pid is active
	# 	and the pid file is older than "minutes"
	# it writes a message to stderr

	# Otherwise, it cleans up after a dead run (if needed)
	# And then returns 0 for success.

	local pidfile="$1"; shift
	local minutes="${1}"; shift

	if [[ -z "$pidfile" ]]
	then
		>&2 echo "No pidfile given to init_pid_file"
		return 1
	fi

	if [ -e "$pidfile" ]
	then # If the pidfile exists
		# Get the pid
		local pid=$(get_pid_from_pidfile "$pidfile")
		if is_process_killable "$pid"
		then # If the process is alive
			# echo "Minutes: $minutes"
			if [[ ! -z "$minutes" ]]
			then # And we've been told to check if it's over a certain time
				if test $(find "$pidfile" -mmin +"$minutes")
				then
					# Write to stderr if it's over than that time
					>&2 echo "Process $pid has a pidfile $pidfile older than $minutes minutes."
				fi
			fi
			return 1
		else
			# Clean up after borked run
			cleanup_pidfile "$pidfile"
		fi
	fi
	echo "$$" > "$pidfile";

	return 0
}

# The goal is (at the end) to have removed the pidfile.
# If it removes a pidfile not belonging to the current process
# then it writes a message to stderr.
function cleanup_pidfile
{
	local pidfile="$1"

	if [[ -z "$pidfile" ]]
	then
		>&2 echo "Error: no pidfile specified for cleanup_pidfile"
		return 1
	fi

	if [[ ! -e "$pidfile" ]]
	then
		>&2 echo "Error: pidfile $pidfile doesn't exist!"
		return 1
	fi

	local pid=$(get_pid_from_pidfile "$pidfile")
	if [[ "$pid" != "$$" ]]
	then
		>&2 echo "Cleaning up pidfile ($pidfile , $pid)  not belonging to my process ($$)..."
	fi
	rm -f "$pidfile"
}
