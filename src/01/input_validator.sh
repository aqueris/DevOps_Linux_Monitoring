#!/bin/bash

function validate_input {
    if [[ $count_var -ne 6 ]]
    then
        echo "invalid number of arguments"
        exit 1
    fi

    last=$(echo "${path}" | tail -c 2)
    if [[ $last == "/" ]] || ! [[ -d $path ]]
    then
        echo "wrong path"
        exit 1
    fi

    reg='^[1-9][0-9]+?$'
    if ! [[ $folders_count =~ $reg ]]
    then
        echo "a non-numeric value has been entered for folders"
        exit 1
    fi

    reg='^[a-zA-Z]{1,7}$'
    if ! [[ $folder_symbols =~ $reg ]]
    then
        echo "incorrect folder name"
        exit 1
    fi

    reg='^[1-9][0-9]+?$'
    if ! [[ $files_count =~ $reg ]]
    then
        echo "a non-numeric value has been entered for files"
        exit 1
    fi

    reg='^[a-zA-Z]{1,7}[.][a-zA-Z]{1,3}$'
    if ! [[ $file_symbols =~ $reg ]]
    then
        echo "incorrect file name"
        exit 1
    fi

    reg='^[1-9][0-9]?[0]?kb$'
    if ! [[ $size =~ $reg ]]
    then
        echo "incorrect size"
        exit 1
    else
        size=$(echo $size | awk -F"kb" '{print $1}')
    fi
}