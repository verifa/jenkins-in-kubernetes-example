#!/bin/bash
# NOTE: JENKINS_ADMIN_PASSWORD is set in ../creds.sh - run that script before this one!

set -x # echo on 

helm repo add jenkins https://charts.jenkins.io
helm repo update

CHART_VERSION=4.1.8

helm upgrade --install jenkins jenkins/jenkins \
             --namespace jenkins \
             --version $CHART_VERSION \
             --set controller.adminUser="admin" \
             --set controller.adminPassword=$JENKINS_ADMIN_PASSWORD \
             -f custom_values.yaml
             
set +x # echo off