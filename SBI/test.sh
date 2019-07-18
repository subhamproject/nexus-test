#!/bin/bash
LOG_FILE=build_fail.log
if grep "BUILD FAILURE" ${LOG_FILE} >> /dev/null;then
 :
 else
 mv ${LOG_FILE} ${LOG_FILE}-txt
 fi
exec > >(tee -a ${LOG_FILE} )
exec 2>&1

export USERID=$(id -u)
export PATH="$PATH:/usr/local/bin"
export GROUPID=$(id -g)
cd $(dirname $0)
#[ $BRANCH_NAME == "master" ] && export NEXUS_REPO=nexus-release || export NEXUS_REPO=nexus-snapshot
docker-compose -f test-bed.yml run --rm -w "$WORKSPACE" --name maven-${BUILD_NUMBER} -e NEXUS_REPO=$NEXUS_REPO --entrypoint "SBI/runtests.sh" maven-app-build
