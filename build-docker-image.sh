#!/bin/bash
function usage {
    echo "usage:"
    echo "$script_name \$jar_file"
    exit 1
}
trap usage ERR
set -e

function main {
    init "$@"
    build_docker_image
}

function init {
    script_name=`basename $0`
    if [ -z "$1" ]
    then
        echo "You must provide a jar file"
        exit 1
    fi
    if [ ! -f "$1" ]
    then
        echo "You must provide a jar file argument was `file $1`"
        exit 1
    fi
    jar_file=$(python -c 'import os,sys;print os.path.realpath(sys.argv[1])' $1)

    has_main_class=`unzip -q -c $jar_file META-INF/MANIFEST.MF|grep Main-Class`

    if [ -z "$has_main_class" ]
    then
        echo "Illegal jar file"
        exit 1
    fi

    script_root=`dirname $(python -c 'import os,sys;print os.path.realpath(sys.argv[1])' $0)`
    project_root=/tmp/docker-$$.$RANDOM
}

function build_docker_image {
    mkdir $project_root
    cp $jar_file $project_root
    cp $script_root/scripts/start-app.sh $project_root
    export JAR_FILE=`basename $jar_file`
    render_template $script_root/templates/Dockerfile > $project_root/Dockerfile
    cd $project_root
    docker build -t `echo $JAR_FILE|tr '[:upper:]' '[:lower:]'` .
}

function render_template {
    eval "echo \"$(cat $1)\""
}
main "$@"
