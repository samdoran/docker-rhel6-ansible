#!/bin/bash

echo "Building Docker image"
docker build --no-cache -t samdoran/rhel6-ansible --build-arg RHSM_USERNAME=$RHSM_USERNAME --build-arg RHSM_PASSWORD=$RHSM_PASSWORD --build-arg RHSM_POOL_ID=$RHSM_POOL_ID .

echo "Pushing to Docker Hub"
docker push samdoran/rhel6-ansible
