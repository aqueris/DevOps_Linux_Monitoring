#!/bin/bash
. ./input_validator.sh
. ./spam_generator.sh

export count_var=${#}
export folder_symbols=${1}
export file_symbols=${2}
export size=${3}

validate_input
spam