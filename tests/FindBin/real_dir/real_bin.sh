#!/bin/bash

script_dir=$( dirname $(realpath "$0") )

# echo "script_dir: $script_dir"

. "$script_dir"/../../../src/lib/bash4/IAS/BashInfra/FindBin.sh

bash_findbin_debug_perl_equiv
