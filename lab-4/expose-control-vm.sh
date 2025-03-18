#!/bin/bash

ISTIO_INGRESS_ROUTE_URL=istio-ingressgateway-istio-system.apps.cluster-szndb.dynamic.redhatworkshops.io

echo
echo
echo "Apply initial Istio Configs to expose control to external Traffic via Service Mesh Ingress"
echo "---------------------------------------------------------------------------------"

echo "Service Mesh Ingress Gateway Route"
echo "Ingress Route [$ISTIO_INGRESS_ROUTE_URL]"
echo
                
echo
echo                
echo "kind: Gateway
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: control-gateway
  namespace: istio-system
spec:
  servers:
    - hosts:
        - $ISTIO_INGRESS_ROUTE_URL
      port:
        name: http
        number: 80
        protocol: HTTP
  selector:
    istio: ingressgateway"|oc  apply -f -


#echo "Ingress Route [$PREFIX.$DOMAIN_NAME]"
#echo
#echo "kind: VirtualService
#apiVersion: networking.istio.io/v1alpha3
#metadata:
#  name: control
#  namespace: travel-control
#spec:
#  hosts:
#    - $PREFIX.$DOMAIN_NAME
#  gateways:
#    - $SM_CP_NS/control-gateway
#  http:
#    - route:
#        - destination:
#            host: control.travel-control.svc.cluster.local
#            subset: v1
#          weight: 100"
          
echo "kind: VirtualService
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: control
  namespace: travel-control
spec:
  hosts:
    - $ISTIO_INGRESS_ROUTE_URL
  gateways:
    - istio-system/control-gateway
  http:
    - route:
        - destination:
            host: control-vm.travel-control.svc.cluster.local
            subset: v1
          weight: 100"|oc  -n travel-control apply -f -          
          
#echo "kind: DestinationRule
#apiVersion: networking.istio.io/v1alpha3
#metadata:
#  name: control
#  namespace: travel-control
#spec:
#  host: control.travel-control.svc.cluster.local
#  subsets:
#    - labels:
#        version: v1
#      name: v1"
      
echo "kind: DestinationRule
apiVersion: networking.istio.io/v1alpha3
metadata:
  name: control
  namespace: travel-control
spec:
  host: control-vm.travel-control.svc.cluster.local
  subsets:
    - labels:
        version: v1
      name: v1"|oc  -n travel-control apply -f -

