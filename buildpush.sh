#!/bin/bash

echo "Building container image"
docker build --no-cache -t quay.io/samdoran/rhel6-ansible --build-arg RHSM_USERNAME=$RHSM_USERNAME --build-arg RHSM_PASSWORD=$RHSM_PASSWORD --build-arg RHSM_POOL_ID=$RHSM_POOL_ID .

echo "Pushing to Quay"
docker push quay.io/samdoran/rhel6-ansible
