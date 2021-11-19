#!/bin/bash

BASH_FINDBIN_SCRIPT=$(basename "$0")
BASH_FINDBIN_BIN=$(dirname "$(realpath --no-symlinks "$0")")

BASH_FINDBIN_REALSCRIPT=$(basename "$(realpath "$0")")
BASH_FINDBIN_REALBIN=$(dirname "$(realpath "$0")")

if [[ "$BASH_FINDBIN_SCRIPT" == "-bash" ]]; then
	 BASH_FINDBIN_SCRIPT="${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}"
fi


function bash_findbin_debug_perl_equiv
{
	echo "\$Bin: ${BASH_FINDBIN_BIN}"
	echo "\$Script: ${BASH_FINDBIN_SCRIPT}"
	
	echo "\$RealBin: ${BASH_FINDBIN_REALBIN}"
	echo "\$RealScript: ${BASH_FINDBIN_REALSCRIPT}"
}

function bash_findbin_debug
{
	echo "BASH_FINDBIN_BIN: ${BASH_FINDBIN_BIN}"
	echo "BASH_FINDBIN_SCRIPT: ${BASH_FINDBIN_SCRIPT}"
	
	echo "BASH_FINDBIN_REALBIN: ${BASH_FINDBIN_REALBIN}"
	echo "BASH_FINDBIN_REALSCRIPT: ${BASH_FINDBIN_REALSCRIPT}"
}



if [[ -z "$BASH_FINDBIN_REALSCRIPT" ]]; then
	>&2 echo "BASH_FINDBIN_REALSCRIPT is empty"
	exit 1
fi


function bash_findbin_is_bin_a_symlink
{
	if [[ "$BASH_FINDBIN_SCRIPT" != "$BASH_FINDBIN_REALSCRIPT" ]]; then
		return 0
	fi
	return 1
}

