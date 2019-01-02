#!/bin/bash
set -e  # Stop on any error
set -u  # Stop when using any undefined variable

# Update with the names of all containers to build.
CONTAINERS="master git jenkins tower"

# NOTES:
# If the docer system gets confused, you can clean out all running containers
# sudo docker stop $(docker ps -a -q) && \
# sudo docker update --restart=no $(docker ps -a -q) && \
# sudo systemctl restart docker

# 1: Setup ssh keys if needed
for X in ${CONTAINERS}  ; do
  mkdir -p ${X}
  cd ${X}
  if [ ! -e "${X}_key" ] ; then
    ssh-keygen -N '' -f ${X}_key
  else
    echo "Key for ${X} exists: $(ls -1 ${X}_key)"
  fi
  cd ..
done

# Pull down pre-built files from other repos.
# # 1. Artifactory and Xray
# if [ ! -e artifactory-docker-examples ] ; then
#   git clone https://github.com/jfrog/artifactory-docker-examples.git
# fi
# cd artifactory-docker-examples
# git pull
# cd ..
# if [ ! -e artifactory ] ; then
#   ln -s artifactory-docker-examples/docker-compose/artifactory .
# fi

# Setup persistent directories
mkdir -p ${PWD}/data
sudo ln -fs ${PWD}/data /data
# # Artifactory
# mkdir -p ${PWD}/data/postgresql
# mkdir -p ${PWD}/data/artifactory
# Git
mkdir -p ${PWD}/data/git
# Jenkins
mkdir -p ${PWD}/jenkins_home
# Ansible
mkdir -p ${PWD}/data/ansible

# Stop any previously running containers
sudo docker stop $(docker ps -a -q) >/dev/null 2>&1

# Start up systems
# Tower, Git, Jenkins
docker rm tower1 jenkins1 git1
docker-compose build
docker-compose up -d

# # Artifactory and XRay
# docker-compose -f artifactory/artifactory-oss-postgresql.yml up -d

# Wait for the Jenkins key to get generated.
EC=1
COUNTER=0
while [[ ${EC} -ne 0 && ${COUNTER} -le 60 ]] ; do
  set +e
  docker exec -ti jenkins1 cat /var/jenkins_home/secrets/initialAdminPassword > /dev/null 2>&1
  EC=$?
  set -e
  [[ ${EC} -ne 0 ]] && sleep 1
  COUNTER=$(( $COUNTER + 1 ))
done

if [[ ${COUNTER} -le 60 ]] ; then
  # Finished!  Should see all our running images:
  echo "FINISHED - Should see all the running images"
  docker ps

  echo "Now pull up a browser to the Jenkins system and enter in"
  echo "this one-time password: $(docker exec -ti jenkins1 cat /var/jenkins_home/secrets/initialAdminPassword)"
else
  echo "Unknown state - Jenkins did not create the initialAdminPassword file."
  echo "Please check the containers."
fi
