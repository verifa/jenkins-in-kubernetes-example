#!/bin/bash

# This all-in-one script does everything:
#  1. Environment setup (creds.sh)
#  2. Terraform apply
#  3. Create namespace (and any other Kubernetes resources we add)
#  4. Deploy Jenkins (jenkins/deploy.sh)

source "$(pwd)/creds.sh"

AZ_SUBSCRIPTION=""
AZ_AKS_RG="rg-jenkinsk8sexample"
AZ_AKS_NAME="aks-jenkinsk8sexample"

echo "Executing: terraform apply"
terraform apply
echo "Execution complete."
echo "==================="
echo "Executing: az aks get-credentials --subscription $AZ_SUBSCRIPTION --resource-group $AZ_AKS_RG --name $AZ_AKS_NAME"
az aks get-credentials --subscription $AZ_SUBSCRIPTION --resource-group $AZ_AKS_RG --name $AZ_AKS_NAME
echo "Execution complete."
echo "==================="
echo "Executing: kubectl apply -f jenkins/kubernetes-manifests"
kubectl apply -f jenkins/kubernetes-manifests
echo "Execution complete."
echo "==================="
# Deploy Jenkins
echo "Deploying Jenkins"
cd jenkins
source deploy.sh
echo "Jenkins deployment complete."
echo "==================="
