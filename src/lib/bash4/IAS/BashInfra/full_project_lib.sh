#!/bin/bash

IAS_BASH_INFRA_LIB_DIR="$IAS_BASH_INFRA_LIB_DIR"
if [[ -z "$IAS_BASH_INFRA_LIB_DIR" ]]; then
	IAS_BASH_INFRA_LIB_DIR=$(dirname "${BASH_SOURCE[0]}")
fi

# shellcheck disable=SC1090
. "$IAS_BASH_INFRA_LIB_DIR/full_project_variables.sh"
# shellcheck disable=SC1090
. "$IAS_BASH_INFRA_LIB_DIR/FindBin.sh"
# shellcheck disable=SC1090
. "$IAS_BASH_INFRA_LIB_DIR/project_path_chooser.sh"
# shellcheck disable=SC1090
. "$IAS_BASH_INFRA_LIB_DIR/project_standard_functions.sh"
# shellcheck disable=SC1090
. "$IAS_BASH_INFRA_LIB_DIR/full_project_path_functions.sh"
# shellcheck disable=SC1090
. "$IAS_BASH_INFRA_LIB_DIR/full_project_load_environment.sh"
# shellcheck disable=SC1090
. "$IAS_BASH_INFRA_LIB_DIR/bash_log_dispatcher.sh"


check_logging_setup
