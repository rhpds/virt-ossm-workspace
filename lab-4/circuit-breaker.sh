#!/bin/bash


echo
echo
echo "Add a circuit breaker for the cars-vm v2 to the cars DestinationRule"
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
