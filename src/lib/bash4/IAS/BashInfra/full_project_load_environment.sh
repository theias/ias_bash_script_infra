#!/bin/bash

environment_conf_file="`get_conf_dir`/environment.sh"

if [[ ! -f "$environment_conf_file" ]]; then
	if [[ "${ENVIRONMENT_CONFIG_REQUIRED}" == '1' ]]; then
		>&2 echo "ERROR: $environment_conf_file doesn't exist."
		>&2 echo "It should contain either:"
		>&2 echo "ENVIRONMENT='PROD'"
		>&2 echo "or"
		>&2 echo "ENVIORNMENT='DEV'"
		exit 1
	fi
else
	. "${environment_conf_file}"
fi

