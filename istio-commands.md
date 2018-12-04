# get generic cluster info
kubectl cluster-info

# get deployments in all namespaces
kubectl get deployments --all-namespaces

# get info on kubernetes-dashboard in kubernetes namespace
kubectl describe deployment kubernetes-dashboard --namespace=kube-system

# get info on all services
kubectl get services --all-namespaces

# get info on specific service in a specific namespace
kubectl describe service kubernetes-dashboard --namespace=kube-system
