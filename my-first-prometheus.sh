#!/bin/bash

export HTTPS_PROXY="http://localhost:3128"

# create resource group in azure
az group create --name myResourceGroup --location "West Europe"

# create service usage plan $$
az appservice plan create --name myAppServicePlan --resource-group myResourceGroup --sku B1 --is-linux

# create webapp
az webapp create --resource-group myResourceGroup --plan myAppServicePlan --name prometheusApp --deployment-container-image-name docker.io/prom/prometheus

# close app
echo -n "Press any key to shutdown container"
read KEY

# close resource group
az group delete --name myResourceGroup

exit 0

# firewall outgoing (standaard open)
# https://docs.microsoft.com/nl-nl/azure/virtual-network/virtual-networks-overview

# logging

# security

# persistence

# monitoring

# red/blue
