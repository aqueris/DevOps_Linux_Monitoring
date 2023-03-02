#!/bin/bash
. ./input_validator.sh
. ./spam_cleaner.sh

export count_var=${#}
export option=${1}

validate_input