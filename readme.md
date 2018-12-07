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

# get and configure credentials for kubectl
az aks get-credentials --resource-group myResourceGroup --name myAKSCluster
```

3. Create an **Azure Container Registry (acr)** (name should be unique)

`az acr create --resource-group myResourceGroup --name $ACR_NAME --sku Basic`

4. Register the kubernetes cluster against your container registry

```
CLIENT_ID=$(az aks show --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "servicePrincipalProfile.clientId" --output tsv)
ACR_ID=$(az acr show --name $ACR_NAME --resource-group $ACR_RESOURCE_GROUP --query "id" --output tsv)

az role assignment create --assignee $CLIENT_ID --role Reader --scope $ACR_ID
```

5. Publish Container in your container registry

[Azure Docs](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-auth-aks)

To be able to publish containers to the registry from your machine, run the following code
```bash
#!/bin/bash

AKS_RESOURCE_GROUP=myResourceGroup
AKS_CLUSTER_NAME=myAKSCluster
ACR_RESOURCE_GROUP=myResourceGroup
ACR_NAME=sudeshContainerRegistry

# Get the id of the service principal configured for AKS
CLIENT_ID=$(az aks show --resource-group $AKS_RESOURCE_GROUP --name $AKS_CLUSTER_NAME --query "servicePrincipalProfile.clientId" --output tsv)

# Get the ACR registry resource id
ACR_ID=$(az acr show --name $ACR_NAME --resource-group $ACR_RESOURCE_GROUP --query "id" --output tsv)

# Now authenticate the AKS cluster against the container registry
az role assignment create --assignee $CLIENT_ID --role Reader --scope $ACR_ID
```

# Publishing a container to your registry

1. Login to your registry

`az acr login --name sudeshcontainerregistry`

2. Push your image

`docker push sudeshcontainerregistry.azurecr.io/prometheus-hello:v1`

3. Deploy your image

`kubectl apply -f kubes/prometheus.yml`

[kubes/prometheus.yml](kubes/prometheus.yml)

4. Check it

```bash
kubectl get deployments
kubectl get pods
kubectl get services
```

# Installing ISTIO in your AKS Cluster

## Install ISTIO
First download istio on your laptop and add it to your PATH \
[Istio Docs](https://istio.io/docs/setup/kubernetes/download-release/)

Then install using [helm and tiller](https://istio.io/docs/setup/kubernetes/helm-install/) by running the following commands

```
cd ~/git/istio
kubectl apply -f install/kubernetes/helm/helm-service-account.yaml
helm init --service-account tiller
helm install install/kubernetes/helm/istio --name istio --namespace istio-system
```

## Install the ISTIO demo app

[istio bookinfo application](https://istio.io/docs/examples/bookinfo/)

1. Enable automatic sidecar injection in the **default** namespace

`kubectl label namespace default istio-injection=enabled`

2. Deploy the services

`kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml`

3. Enable access to the services by creating a gateway

`kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml`

4. Cofirm that services and gateway are running

```
kubectl get services
kubectl get gateway
```
