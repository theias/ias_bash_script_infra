#!/bin/bash

BASH_FINDBIN_MAXSYMLINKS=50
BASH_FINDBIN_SCRIPT="$0"

if [[ "$BASH_FINDBIN_SCRIPT" == "-bash" ]]; then
	 BASH_FINDBIN_SCRIPT=`echo "${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}"`
fi

BASH_FINDBIN_BIN="$( cd "$(dirname "$BASH_FINDBIN_SCRIPT")" ; pwd )"

BASH_FINDBIN_READLINK="/bin/readlink"

function bash_findbin_resolve_path
{
	local resolve_this
	local iteration
	
	resolve_this="$1"
	iteration="$2"
	
	# >&2 echo "Resolving: $resolve_this"
	
	if [[ ! -z ${iteration+x} ]]; then
		iteration=1
	fi

	if (( "$BASH_FINDBIN_MAXSYMLINKS" <= "$iteration" )); then
		>&2 echo "bash_findbin_resolve_path has iterated $BASH_FINDBIN_MAXSYMLINKS (too many) times..."
		return
	fi
	
	if [[ -h "$resolve_this" ]]
	then
		local real_path
		real_path=`${BASH_FINDBIN_READLINK} "$resolve_this"`
	
		if [[ "$resolve_this" != "$real_path" ]]; then
			bash_findbin_resolve_path "$real_path" "$iteration"
			return
		fi
	fi
	# >&2 echo GOT HERE $resolve_this
	
	echo "$resolve_this"
}

function bash_findbin_debug
{
	echo "BASH_FINDBIN_MAXSYMLINKS: ${BASH_FINDBIN_MAXSYMLINKS}"
	echo "BASH_FINDBIN_SCRIPT: ${BASH_FINDBIN_SCRIPT}"
	echo "BASH_FINDBIN_BIN: ${BASH_FINDBIN_BIN}"
	
	echo "BASH_FINDBIN_REALSCRIPT: ${BASH_FINDBIN_REALSCRIPT}"
	echo "BASH_FINDBIN_REALBIN: ${BASH_FINDBIN_REALBIN}"
}

BASH_FINDBIN_REALSCRIPT=`bash_findbin_resolve_path "$BASH_FINDBIN_SCRIPT"`

# BASH_FINDBIN_REALSCRIPT=''

if [[ ! -n "$BASH_FINDBIN_REALSCRIPT" ]]; then
	>&2 echo "BASH_FINDBIN_REALSCRIPT is empty"
	exit 1
fi

BASH_FINDBIN_REALBIN="$( cd "$(dirname "$BASH_FINDBIN_REALSCRIPT")" ; pwd )"

function bash_findbin_is_bin_a_symlink
{
	if [[ "$BASH_FINDBIN_SCRIPT" != "$BASH_FINDBIN_REALSCRIPT" ]]; then
		return 0
	fi
	return 1
}



