#!/bin/bash

TF_STATE_RESOURCE_GROUP=rg-terraformStorage
TF_STATE_ACCOUNT_NAME=terraformstorage
TF_STATE_KEY_VAULT=kv-terraformstorage

export ARM_SUBSCRIPTION_ID=
export ARM_TENANT_ID=
export TF_VAR_client_id=

export ARM_ACCESS_KEY=$(az storage account keys list --subscription $ARM_SUBSCRIPTION_ID --resource-group $TF_STATE_RESOURCE_GROUP --account-name $TF_STATE_ACCOUNT_NAME --query [0].value -o tsv | tr -d '"')

ip_addr=$(curl https://icanhazip.com)

az keyvault network-rule add --subscription $ARM_SUBSCRIPTION_ID --name $TF_STATE_KEY_VAULT --ip-address $ip_addr
export TF_VAR_client_secret=$(az keyvault secret show --subscription $ARM_SUBSCRIPTION_ID --vault-name $TF_STATE_KEY_VAULT --name service-principal-secret --query value | tr -d '"')
export JENKINS_ADMIN_PASSWORD=$(az keyvault secret show --subscription $ARM_SUBSCRIPTION_ID --vault-name $TF_STATE_KEY_VAULT --name jenkins-in-kubernetes-example-admin-password --query value | tr -d '"')
az keyvault network-rule remove --subscription $ARM_SUBSCRIPTION_ID --name $TF_STATE_KEY_VAULT --ip-address "${ip_addr}/32"
