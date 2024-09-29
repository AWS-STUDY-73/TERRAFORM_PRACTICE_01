#!/bin/bash

<< readme
This script is used to take regular automated backups
of the database and files on the server.

Usage:
    ./backup.sh <source_directory> <destination_directory>
readme

function dispplay_usage {
    echo "Usage: ./backup.sh <source_directory> <destination_directory>"
}

if [ $# -eq 0 ]; then
    dispplay_usage
fi

source_dir=$1
dest_dir=$2
timestamp=$(date '+%Y%m%d_%H%M%S')

function create_bkp {
    zip -r "${dest_dir}/backup_${timestamp}.zip" "${source_dir}" >/dev/null

    if [ $? -eq 0 ]; then
        echo "Backup created successfully at ${dest_dir}/backup_${timestamp}.zip"
    fi
}

function perf_retension {
    backups=($(ls -t "${dest_dir}/backup_"*.zip))

    if [ ${#backups[@]} -gt 5 ]; then
        echo "Performing Retension of 5"

        backups_to_remove=("${backups[@]:5}")
        for backups in "${backups_to_remove[@]}";
        do
            rm -f "${backups}"
        done
    fi
}

create_bkp
perf_retension