#!/bin/bash

LIB_INST_DIR="$LIB_INST_DIR"
if [[ -z "$LIB_INST_DIR" ]]; then
	LIB_INST_DIR=/opt/IAS/lib
fi

IAS_BASH_INFRA_LIB_DIR="$IAS_BASH_INFRA_LIB_DIR"
if [[ -z "$IAS_BASH_INFRA_LIB_DIR" ]]; then
	IAS_BASH_INFRA_LIB_DIR="${LIB_INST_DIR}/bash4/IAS/BashInfra"
fi

. $IAS_BASH_INFRA_LIB_DIR/FindBin.sh
. $IAS_BASH_INFRA_LIB_DIR/project_path_chooser.sh
. $IAS_BASH_INFRA_LIB_DIR/project_standard_functions.sh
. $IAS_BASH_INFRA_LIB_DIR/full_project_path_functions.sh
. $IAS_BASH_INFRA_LIB_DIR/full_project_load_environment.sh
. $IAS_BASH_INFRA_LIB_DIR/bash_log_dispatcher.sh

