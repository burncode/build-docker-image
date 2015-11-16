#!/bin/bash
set -e
function main {
    init "$@"
    build-docker-image
}

function init {
    script_name=`basename $0`
    script_root=`dirname $(python -c 'import os,sys;print os.path.realpath(sys.argv[1])' $0)`
    if [ -z "$1" ]
    then
        project_root=`pwd`
    else
        project_root=$(python -c 'import os,sys;print os.path.realpath(sys.argv[1])' $1)
        if [ ! -d "$project_root" ]
        then
            echo "Argument must be a directory"
            usage
        fi
    fi
    dockerfile_template=project
}

function usage {
    echo "$script_name <project_dir>"
    exit 1
}

function build-docker-image {
    echo $script_root
    echo $project_root
}
main "$@"
