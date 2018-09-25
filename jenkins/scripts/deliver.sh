#!/usr/bin/env bash

set -x
env

echo 'The following Maven command installs your Maven-built Java application'
echo 'into the local Maven repository, which will ultimately be stored in'
echo 'Jenkins''s local Maven repository (and the "maven-repository" Docker data'
echo 'volume).'
set -x
mvn jar:jar install:install help:evaluate -Dexpression=project.name
set +x

echo 'The following complex command extracts the value of the <name/> element'
echo 'within <project/> of your Java/Maven project''s "pom.xml" file.'
set -x
NAME=`mvn help:evaluate -Dexpression=project.name | grep "^[^\[]"`
set +x

echo 'The following complex command behaves similarly to the previous one but'
echo 'extracts the value of the <version/> element within <project/> instead.'
set -x
VERSION=`mvn help:evaluate -Dexpression=project.version | grep "^[^\[]"`
set +x

echo 'The following command runs and outputs the execution of your Java'
echo 'application (which Jenkins built using Maven) to the Jenkins UI.'
set -x
java -jar target/${NAME}-${VERSION}.jar

set -x
echo 'The following command runs curl to push the jar to a nexus repository on another server.'
set -x
curl -v -u ${NexusUser}:${NexusPW} --upload-file target/${NAME}-${VERSION}.jar http://johndavidmarx3.mylabserver.com:8081/repository/maven-snapshots/Linux_Academy/${NAME}-${VERSION}.jar

set -x
curl --cookie-jar cookie.txt "https://console.deployhub.com/dmadminweb/API/login?user=developer&pass=any"

set -x
curl -b cookie.txt "https://console.deployhub.com/dmadminweb/API/deploy/HelloWorldApp%3B1/GLOBAL.Linux%20Academy.DevSecOps.My%20Pipeline.Development.Dev?task=Deploy%20to%20Dev&wait=n"
