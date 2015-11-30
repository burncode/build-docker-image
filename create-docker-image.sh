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
trap usage ERR EXIT
set -e

function main {
    init "$@"
    build_docker_image
    push_docker_image
}

function init {
    if [ ! -f info.txt ]
    then
        error 1
    fi
    set -a
    . info.txt
    set +a
    has_main_class=`unzip -q -c $JAR_FILE META-INF/MANIFEST.MF|grep Main-Class`

    if [ -z "$has_main_class" ]
    then
        error 2
    fi

    script_root=`dirname $(python -c 'import os,sys;print os.path.realpath(sys.argv[1])' $0)`
    project_root=/tmp/docker-$$.$RANDOM
}

function build_docker_image {
    mkdir $project_root
    cp $JAR_FILE $project_root/app.jar
    export JAR_FILE=app.jar
    render_template $script_root/scripts/start-app.sh > $project_root/start-app.sh
    render_template $script_root/templates/Dockerfile > $project_root/Dockerfile
    cd $project_root
    docker build -t $APP_NAME:$BUILD_NO .
}

function push_docker_image {
    docker tag -f $APP_NAME:$BUILD_NO localhost:5000/$APP_NAME:$BUILD_NO
    docker push localhost:5000/$APP_NAME:$BUILD_NO
}

function error {
    errors[1]="This script must be executed in a directory containing a info.txt file"
    errors[2]="Illigal jar file"
    echo ${errors[$1]}
    exit $1
}

function render_template {
    eval "echo \"$(cat $1)\""
}
main "$@"
