#!/bin/bash


echo
echo
echo "Apply a Second cars-vm instance with v2"
echo "---------------------------------------------------------------------------------"
#oc apply -f cars-vm-v2-no-sidecar.yaml  -n travel-agency
#oc delete pods -l vm.kubevirt.io/name=cars-vm-v2 -n travel-agency


echo
echo
echo "Create a cars DestinationRule with multiple Circuit Breaker"
echo "---------------------------------------------------------------------------------"
echo "kind: DestinationRule
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: cars
  namespace: travel-agency
  labels:
    module: m4
spec:
  host: cars-vm.travel-agency.svc.cluster.local
  subsets:
    - labels:
        version: v1
      name: v1
    - labels:
        version: v2
      name: v2      
      trafficPolicy:
        connectionPool:
          http:
            http1MaxPendingRequests: 1
            maxRequestsPerConnection: 1
          tcp:
            maxConnections: 1
        outlierDetection:
          baseEjectionTime: 3m
          consecutive5xxErrors: 1
          interval: 1s
          maxEjectionPercent: 100"

echo          

echo "kind: DestinationRule
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: cars
  namespace: travel-agency
  labels:
    module: m4
spec:
  host: cars-vm.travel-agency.svc.cluster.local
  subsets:
    - labels:
        version: v1
      name: v1
    - labels:
        version: v2
      name: v2      
      trafficPolicy:
        connectionPool:
          http:
            http1MaxPendingRequests: 1
            maxRequestsPerConnection: 1
          tcp:
            maxConnections: 1
        outlierDetection:
          baseEjectionTime: 3m
          consecutive5xxErrors: 1
          interval: 1s
          maxEjectionPercent: 100"|oc  -n travel-agency apply -f -
