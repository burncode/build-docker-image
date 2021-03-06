#!/bin/bash
script_name=`basename $(python -c 'import os,sys;print os.path.realpath(sys.argv[1])' $0)`
usage() {
    status=$?
    if [ ! "$status" = 0 ]
    then
        echo "Usage:"
        echo "$script_name <dirname>(optional)"
        exit $status
    fi
}

set -e
trap usage ERR EXIT


function main {
    init "$@"
    . $1
    validate
}

function init {
    if [ ! -f "$1" ]
    then
        error 1
    fi
}

function validate {
    if [ -z "$APP_NAME" ] || [ -z "$BUILD_NO" ] || [ -z "$JAR_FILE" ]
}

error_array[1]="Argument must be a file"

error () {
    echo ${error_array[$1]}
    exit $1
}

main "$@"
