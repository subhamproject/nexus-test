#!/bin/bash

export PATH="$PATH:/usr/local/bin"
export USERID=$(id -u)
export GROUPID=$(id -g)
echo "Running as UID=$USERID, GID=$GROUPID on branch $BRANCH_NAME"
cd $(dirname $0)
[ $BRANCH_NAME == "master" ] && export NEXUS_REPO=nexus-release || export NEXUS_REPO=nexus-snapshot
docker-compose -f test-bed.yml run --name maven-${BUILD_NUMBER} --rm -w "$WORKSPACE" -e NEXUS_REPO=$NEXUS_REPO --entrypoint "mvn -s settings.xml clean deploy" maven-app-build
