# azure-docs
Constraints and considerations when developing applications on top of the Azure public cloud

0. Define your variables (in ~/.bashrc?)
```
AKS_RESOURCE_GROUP=myResourceGroup
AKS_CLUSTER_NAME=myAKSCluster
ACR_NAME=sudeshContainerRegistry
```

1. Create a resource group
az group create --name myResourceGroup --location "West Europe"

2. Create an AKS cluster (preferrably mod 3 nodecount for quorum)
az aks create --resource-group myResourceGroup --name myAKSCluster --node-count 2 --kubernetes-version 1.10.9 --generate-ssh-keys

3. Create a container registry (name should be unique)
az acr create --resource-group myResourceGroup --name sudeshContainerRegistry --sku Basic

4. Register the kubernetes cluster against your container registry
```
CLIENT_ID=$(az aks show --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "servicePrincipalProfile.clientId" --output tsv)
ACR_ID=$(az acr show --name $ACR_NAME --resource-group $ACR_RESOURCE_GROUP --query "id" --output tsv)

az role assignment create --assignee $CLIENT_ID --role Reader --scope $ACR_ID
```

5. 
