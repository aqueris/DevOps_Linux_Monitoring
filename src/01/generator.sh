#!/bin/bash

function generate_folder_names {
    touch log.txt
    for (( number=0; number <$folders_count; number++ ))
    do
        folder_name=""
        if [[ ${#folder_symbols} -lt 4 ]]
        then
            generate_short_name
            create_files
        else
            generate_long_name
            create_files
        fi
    done
}

function generate_short_name {
    count=${#folder_symbols}
    for (( i=0; i<5-count; i++ ))
    do
        folder_name+="$(echo ${folder_symbols:0:1})"
    done
    folder_name+="$(echo ${folder_symbols:1:${#folder_symbols}})"
    folder_name+=$number
    folder_name+="_"
    folder_name+=$(date +"%d%m%y")
    mkdir $folder_name
    echo $path"/"$folder_name --- $(date +'%e.%m.%Y') ---  >> log.txt
}

function generate_long_name {
    folder_name=$folder_symbols
    folder_name+=$number
    folder_name+="_"
    folder_name+=$(date +"%d%m%y")
    mkdir $folder_name
    echo $path"/"$folder_name --- $(date +'%e.%m.%Y') ---  >> log.txt
}

function create_files {
    file_name_start="$(echo $file_symbols | awk -F "." '{print $1}')"
    file_name_end="$(echo $file_symbols | awk -F "." '{print $2}')"
    for (( number_files=0; number_files <$files_count; number_files++ ))
    do
        file_name=""
        if [[ ${#file_name_start} -lt 4 ]]
        then
            create_short_name_files
            echo $path"/"$folder_name"/"$file_name --- $(date +'%e.%m.%Y') --- $size "Kb" >> log.txt
        else
            create_long_name_files
            echo $path"/"$folder_name"/"$file_name --- $(date +'%e.%m.%Y') --- $size "Kb" >> log.txt
        fi
    done
}

function create_short_name_files {
    count=${#file_name_start}
    for (( i=0; i<5-count; i++ ))
    do
        file_name+="$(echo ${file_name_start:0:1})"
    done
    file_name+="$(echo ${file_name_start:1:${#file_name_start}})"
    file_name+=$number_files
    file_name+="_"
    file_name+=$(date +"%d%m%y")
    file_name+="."
    file_name+=$file_name_end
    fallocate -l $size"KB" ./$folder_name/$file_name

    if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
    then
        exit 1
    fi
}

function create_long_name_files {
    file_name+="$(echo ${file_name_start:0:${#file_name_start}})"
    file_name+=$number_files
    file_name+="_"
    file_name+=$(date +"%d%m%y")
    file_name+="."
    file_name+=$file_name_end
    fallocate -l $size"KB" ./$folder_name/$file_name
    if [[ $(df / -BM | grep "/" | awk -F"M" '{ print $3 }') -le 1024 ]]
    then
        exit 1
    fi
}