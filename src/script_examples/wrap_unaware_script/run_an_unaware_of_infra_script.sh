#!/bin/bash

#\BEGIN:redacted
#\ This files documentation uses "embedded markdown".
#\ Lines starting with #\ can be removed (or extracted) with:
#\ ```grep -vE '^#\\' | sed '/^$/N;/^\n$/D' ```
#\END:redacted

#\ # Introduction 
#\
#\ A full code listing is at the end of this document.  If you're inclined to,
#\ you can read that first.
#\
#\ * This script will be referred to as "This Wrapper".
#\ * The program it's wrapping will be called "The Unaware".
#\
#\ Some (vast majority) of programs have been made which are unaware of:
#\
#\ * behavioral:
#\ 	* the need to log to syslog or to log files and report errors
#\ 	* the ability to simply create sane output file names
#\ * filesystem layout:
#\ 	* repository organization
#\ 	* organization of files when installed
#\
#\ While this is OK, it can lead to problems when (for example) cronning things.
#\
#\ ## Behavioral Wrapping
#\
#\ ### Logging and Error Reporting
#\ 
#\ The Unaware program it's wrapping uses stderr to print status messages and error
#\ messages (yuck).  The Wrapper sends those to syslog (currently).
#\
#\ Due to stderr being used for both status and for error messages, This Wrapper
#\ relies on the exit value of the The Unaware being to be non-zero if
#\ a some error that requires attention has occured.
#\
#\ ### Simple and Sane Output File Names
#\
#\ Countless times (way too many, IMO) programmers write various ways of:
#\
#\ * naming output files with (say): timestamp-label-description.<extension>
#\ * deciding where output files should go
#\ * making the appropriate accomodations for the repository (i.e. .gitignore)
#\ to keep the repository clean.
#\
#\ ## Filesystem Layout
#\
#\ When a program is run from a project directory (such as a git repo)
#\ the configuration files (for example) might be in ```src/bin/../etc``` , but
#\ the location of configuration files when installed via a package
#\ might be ```/opt/IAS/bin/project-name/../../etc/project-name```
#\ i.e. ```/opt/IAS/etc/project-name```
#\ 

#\ # The Code
#\
#\ ## Argument Preservation
#\ 
#\ The first thing we do is save the arguments that the program was run with.
#\ We log them later so that (say) if something goes wrong, we can see
#\ the arguments.

all_arguments=( "$@" )

#\ ## Loading the Infrastructure Libraries
#\
#\ Load libraries that allow us to be aware of directory layouts:

# shellcheck disable=SC1091
. /opt/IAS/lib/bash4/IAS/BashInfra/full_project_lib.sh || exit 1

#\ ## Logging start
#\
#\ Up until now, everything we've done should return nearly instantly.
#\ We send our first log message before "the real work" has begun. 
write_log_start "${all_arguments[@]}"

#\ ## Argument Fetching and Processing for The Wrapper
#\
#\ This is where you'd process arguments that The Wrapper
#\ would use to do its thing.

# (wrapper argument processing goes here)
# my_arg1=$1; shift 

#\ The rest of the arguments are what we're going to pass to
#\ the program that's getting wrapped

rest_of_arguments=( "$@" )

#\ ## Specifying What The Wrapper is Wrapping
#\
#\ In our case, the Wrapper is located relative to The Unaware.
#\ We "hard code this here" ; but it really could be an argument to this script
#\ telling it what to run.

program_to_run="$(get_bin_dir)/unaware_of_infra_script.sh"

#\ get_bin_dir has some special properties; mainly that it allows for The Wrapper
#\ to be symbolically linked to a different location, and run through that
#\ while still maintaing the ability to find its realpath (not hard).
#\
#\ It also has the ability to refer to the symbolic link's location to determine
#\ locations when configured to do so.

#\ ## The Wrapping Code
#\
#\ ```get_output_filename``` returns something like this 
#\ ```output/script-name/date-script-name-extension``` by default.

output_file_name=$(get_output_file_name)

#\ The Wrapper logs stderr of The Unaware by prepending the basename of the program
#\ to the log entry, but it must be escaped so that sed can do the prepending:

program_base_name=$( basename "$program_to_run"  )
pbn_escaped=$(printf '%s\n' "$program_base_name" | sed 's/[\/&]/\\&/g')

#\ This log message is slightly redundant, as the full command that's being
#\ run is logged below, but commdands and the involved paths can get very long,
#\ so we log it separately purely for readability.

write_log_informational "Running: $program_to_run"

#\ We set up the entire command in an array.  This is convienent for a
#\ number of reasons:
#\
#\ * If we desire to do some trickery, we can manipulate the array
#\ * The entire array can be sent to the log
#\
#\ Bug / TODO:  The stdbuf command at the start doesn't cause the output
#\ of The Unware to be line-buffered (as I was expecting when I read
#\ the documentation.
command_to_run=(
	stdbuf --error=L --output=L "$program_to_run" \
		"${rest_of_arguments[@]}"
)

write_log_informational "Full command: ${command_to_run[@]}"

#\ ## Finally Running The Unaware

#\ * redirect the output of the command to our handy-dandy auto-generated
#\ output file name
#\ * use stdbuff to set the pipeline for logging stderr to be line buffered.

"${command_to_run[@]}" \
	> "$output_file_name" \
	2> >( stdbuf --output=L sed "s/^/$pbn_escaped : / " | write_log_informational )

exit_status_of_unaware_script=$?

#\ ## Takin' Care of Cleanup
#\
#\ Make sure the script exited OK; otherwise log an error to The Wrapper's
#\ stderr, which should eventually bubble up through (say) cron:

if [[ $exit_status_of_unaware_script == 0 ]]
then
	write_log_informational "$program_to_run" exited fine.
else
	write_log_error "$program_to_run" failed to run.  Please check logs.
fi

#\ We log the output file name and the exit status number of The Unaware
#\ for posterity

write_log_informational "Wrote: ${output_file_name}"
write_log_informational "Exit status: ${exit_status_of_unaware_script}"

#\ And finally, we close off.
write_log_end

exit $exit_status_of_unaware_script

#\ # Full Code Listing
#\
#\ In my opinion, this code is self-documenting.
#\ The "why" is documented above.
