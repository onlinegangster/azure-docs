# azure-docs
Constraints and considerations when developing applications on top of the Azure public cloud

0. Define your variables (in ~/.bashrc?)
```
AKS_RESOURCE_GROUP=myResourceGroup
AKS_CLUSTER_NAME=myAKSCluster
ACR_NAME=sudeshContainerRegistry
```

1. Create a resource group
`az group create --name myResourceGroup --location "West Europe"`

2. Create an AKS cluster (preferrably mod 3 nodecount for quorum, check MS docs for getting the kubernetes versions available)
```
az aks create --resource-group myResourceGroup --name myAKSCluster --node-count 2 --kubernetes-version 1.10.9 --generate-ssh-keys

# get credentials for kubectl
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
```

3. Create a container registry (name should be unique)
`az acr create --resource-group myResourceGroup --name sudeshContainerRegistry --sku Basic`

4. Register the kubernetes cluster against your container registry
```
CLIENT_ID=$(az aks show --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "servicePrincipalProfile.clientId" --output tsv)
ACR_ID=$(az acr show --name $ACR_NAME --resource-group $ACR_RESOURCE_GROUP --query "id" --output tsv)

az role assignment create --assignee $CLIENT_ID --role Reader --scope $ACR_ID
```

5. Publish Container in your container registry

To be able to publish containers to the registry from your machine, run the following code and note the **service principal id** and **service principal password**
```
#!/bin/bash

ACR_NAME=sudeshContainerRegistry
SERVICE_PRINCIPAL_NAME=acr-service-principal

# Populate the ACR login server and resource id.
ACR_LOGIN_SERVER=$(az acr show --name $ACR_NAME --query loginServer --output tsv)
ACR_REGISTRY_ID=$(az acr show --name $ACR_NAME --query id --output tsv)

# Create a 'Reader' role assignment with a scope of the ACR resource.
SP_PASSWD=$(az ad sp create-for-rbac --name $SERVICE_PRINCIPAL_NAME --role Reader --scopes $ACR_REGISTRY_ID --query password --output tsv)                                                    

# Get the service principal client id.
CLIENT_ID=$(az ad sp show --id http://$SERVICE_PRINCIPAL_NAME --query appId --output tsv)

# Output used when creating Kubernetes secret.
echo "Service principal ID: $CLIENT_ID"
echo "Service principal password: $SP_PASSWD"
```

Now 
