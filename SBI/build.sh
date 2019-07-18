#!/bin/bash
LOG_FILE=build_fail.log
[ -s ${LOG_FILE} ] && >${LOG_FILE}
exec > >(tee -a ${LOG_FILE} )
exec 2>&1

export PATH="$PATH:/usr/local/bin"
export USERID=$(id -u)
export GROUPID=$(id -g)
echo "Running as UID=$USERID, GID=$GROUPID on branch $BRANCH_NAME"
cd $(dirname $0)
#[ $BRANCH_NAME == "master" ] && export NEXUS_REPO=nexus-release || export NEXUS_REPO=nexus-snapshot
docker-compose -f test-bed.yml run --name maven-${BUILD_NUMBER} --rm -w "$WORKSPACE" -e NEXUS_REPO=$NEXUS_REPO --entrypoint "mvn -s settings.xml clean package" maven-app-build
