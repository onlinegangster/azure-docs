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

# list all running istio services
kubectl get svc -n istio-system

# Sidecars
https://istio.io/docs/setup/kubernetes/sidecar-injection/

### inject istio manually
istioctl kube-inject -f prometheus.yml > istio-prometheus.yml

### inject istio and run in cluster
istioctl kube-inject -f prometheus.yml | kubectl apply -f -

### list sidecars
kubectl -n istio-system get pod -listio=sidecar-injector

# Components
https://istio.io/help/ops/component-debugging/

## Istio System Logs
```
for pod in $(kubectl -n istio-system get pod -listio=sidecar-injector -o jsonpath='{.items[*].metadata.name}'); do \
    kubectl -n istio-system logs ${pod} \
done
```
