#!/bin/bash

TRAFFIC_v1=$1
TRAFFIC_v2=$2

echo
echo
echo "Apply a Second cars-vm instance with v2"
echo "---------------------------------------------------------------------------------"
oc apply -f cars-vm-v2.yaml -n travel-agency


sleep 3

echo
echo
echo "Create a cars Destination with multiple possible versions"
echo "---------------------------------------------------------------------------------"


echo "kind: DestinationRule
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: cars
  namespace: travel-agency
  labels:
    module: m3
spec:
  host: cars-vm.travel-agency.svc.cluster.local
  subsets:
    - labels:
        version: v1
      name: v1
    - labels:
        version: v2
      name: v2      "|oc  -n travel-agency apply -f -


echo "Create a weighted loadbalancer between cars v1 (90%) and v2 (10%) versions"
echo "--------------------------------------------------------------------------"

echo "kind: VirtualService
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: cars
  namespace: travel-agency
  labels:
    module: m3
spec:
  hosts:
    - cars-vm.travel-agency.svc.cluster.local
  gateways:
    - mesh
  http:
    - route:
        - destination:
            host: cars-vm.travel-agency.svc.cluster.local
            subset: v1
          weight: $TRAFFIC_v1
        - destination:
            host: cars-vm.travel-agency.svc.cluster.local
            subset: v2
          weight: $TRAFFIC_v2"


echo "kind: VirtualService
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: cars
  namespace: travel-agency
  labels:
    module: m3
spec:
  hosts:
    - cars-vm.travel-agency.svc.cluster.local
  gateways:
    - mesh
  http:
    - route:
        - destination:
            host: cars-vm.travel-agency.svc.cluster.local
            subset: v1
          weight: $TRAFFIC_v1
        - destination:
            host: cars-vm.travel-agency.svc.cluster.local
            subset: v2
          weight: $TRAFFIC_v2"|oc  -n travel-agency apply -f -          
          
