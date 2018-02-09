#!/bin/bash

if [[ ! -f "$CONF_DIR"/environment.sh ]]; then
	if [[ ! -z ${ENVIRONMENT_CONFIG_REQUIRED+x} ]]; then
		>&2 echo "ERROR: $CONF_DIR/environment.sh doesn't exist."
		>&2 echo "It should contain either:"
		>&2 echo "ENVIRONMENT='PROD'"
		>&2 echo "or"
		>&2 echo "ENVIORNMENT='DEV'"
		exit 1
	fi
else
	. "$CONF_DIR"/environment.sh
fi

