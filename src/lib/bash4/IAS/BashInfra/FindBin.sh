#!/bin/bash

BASH_FINDBIN_SCRIPT="$0"

if [[ "$BASH_FINDBIN_SCRIPT" == "-bash" ]]; then
	 BASH_FINDBIN_SCRIPT="${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}"
fi

# BASH_FINDBIN_BIN="$( cd "$(dirname "$BASH_FINDBIN_SCRIPT")" ; pwd )"
BASH_FINDBIN_BIN=$(dirname "$BASH_FINDBIN_SCRIPT")

function bash_findbin_debug
{
	echo "BASH_FINDBIN_SCRIPT: ${BASH_FINDBIN_SCRIPT}"
	echo "BASH_FINDBIN_BIN: ${BASH_FINDBIN_BIN}"
	
	echo "BASH_FINDBIN_REALSCRIPT: ${BASH_FINDBIN_REALSCRIPT}"
	echo "BASH_FINDBIN_REALBIN: ${BASH_FINDBIN_REALBIN}"
}

BASH_FINDBIN_REALSCRIPT=$(realpath "$BASH_FINDBIN_SCRIPT")


if [[ -z "$BASH_FINDBIN_REALSCRIPT" ]]; then
	>&2 echo "BASH_FINDBIN_REALSCRIPT is empty"
	exit 1
fi

BASH_FINDBIN_REALBIN=$(dirname "$BASH_FINDBIN_REALSCRIPT")

function bash_findbin_is_bin_a_symlink
{
	if [[ "$BASH_FINDBIN_SCRIPT" != "$BASH_FINDBIN_REALSCRIPT" ]]; then
		return 0
	fi
	return 1
}

