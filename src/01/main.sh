#!/bin/bash
. ./input_validator.sh
. ./generator.sh

export count_var=${#}
export path=${1}
export folders_count=${2}
export folder_symbols=${3}
export files_count=${4}
export file_symbols=${5}
export size=${6}

validate_input
generate_folder_names