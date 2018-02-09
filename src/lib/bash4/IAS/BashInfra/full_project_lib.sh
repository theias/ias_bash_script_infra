#!/bin/bash

IAS_BASH_INFRA_LIB_DIR="$IAS_BASH_INFRA_LIB_DIR"

if [[ -z "$IAS_BASH_INFRA_LIB_DIR" ]]; then
	IAS_BASH_INFRA_LIB_DIR=/opt/IAS/lib/bash4/IAS/BashInfra
fi

. $IAS_BASH_INFRA_LIB_DIR/FindBin.sh
. $IAS_BASH_INFRA_LIB_DIR/project_path_chooser.sh
. $IAS_BASH_INFRA_LIB_DIR/project_standard_functions.sh
. $IAS_BASH_INFRA_LIB_DIR/full_project_variables.sh
. $IAS_BASH_INFRA_LIB_DIR/full_project_load_environment.sh
. $IAS_BASH_INFRA_LIB_DIR/bash_log_dispatcher.sh

