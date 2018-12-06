# Running an app on Azure (PaaS/native)

1. create resource group in azure
[Azure Regions Map and Replicaton Policy](https://azuredatacentermap.azurewebsites.net/)
az group create --name myResourceGroup --location westeurope

2. create service usage plan $$
az appservice plan create --name myAppServicePlan --resource-group myResourceGroup --sku B1 --is-linux

3. create webapp
az webapp create --resource-group myResourceGroup --plan myAppServicePlan --name prometheusApp --deployment-container-image-name docker.io/prom/prometheus

4. remove app
TODO

5. remove resource group (removes all resources)
az group delete --name myResourceGroup

## firewall outgoing (standaard open)
https://docs.microsoft.com/nl-nl/azure/virtual-network/virtual-networks-overview

# logging

# security

# persistence

# monitoring

# red/blue
