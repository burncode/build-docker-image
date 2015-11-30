#!/bin/bash
script_name=`basename $(python -c 'import os,sys;print os.path.realpath(sys.argv[1])' $0)`
function usage {
    echo "Usage:"
    echo "$script_name <dirname>(optional)"
    exit 1
}
set -e
trap usage ERR


function main {
    init "$@"
    python -c 'import os,sys;print os.path.realpath(sys.argv[1])' $(get-name)
}

function init {
    if [ ! -z "$1" ]
    then
        if [ ! -d "$1" ]
        then
            echo "Argument must be a directory"
            exit 1
        fi
        jar_dir="$1"
    else
        jar_dir="./"
    fi
}

function get-name {
    jar_name=$(find $jar_dir -name "*standalone*.jar*")
    if [ -z "$jar_name" ]
    then
        echo "No jar found"
        exit 1
    fi
    echo $jar_name
}

main "$@"
