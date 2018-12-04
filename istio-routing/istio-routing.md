# Check external endpoint (istio ingressgateway/loadbalancer)
# https://kublr.com/blog/implementing-a-service-mesh-with-istio-to-simplify-microservices-communication/
kubectl get services istio-ingressgateway -n istio-system
