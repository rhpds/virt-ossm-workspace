#!/bin/bash

echo "kind: VirtualService
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: control
  namespace: travel-control
spec:
  hosts:
    - istio-ingressgateway-istio-system.apps.cluster-9qw64.dynamic.redhatworkshops.io
  gateways:
    - istio-system/control-gateway
  http:
    - route:
        - destination:
            host: control.travel-control.svc.cluster.local
            subset: v1
          weight: 100"|oc apply -f -          

      
echo "kind: DestinationRule
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: control
  namespace: travel-control
spec:
  host: control.travel-control.svc.cluster.local
  subsets:
    - labels:
        version: v1
      name: v1"|oc apply -f -     
