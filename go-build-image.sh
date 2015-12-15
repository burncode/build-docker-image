#!/bin/bash
app_version=$APP_NAME:$BUILD_NO.$GO_PIPELINE_COUNTER
docker build -t $app_version .
docker tag -f $app_version 172.21.14.12:5000/$app_version
docker push 172.21.14.12:5000/$app_version
