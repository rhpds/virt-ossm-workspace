#!/bin/bash

#ENV_ORIGINAL=$1
#SM_CP_NS_ORIGINAL=$2
#DOMAIN_NAME=$3
#PARTICIPANTID=$4
#PREFIX=travel-$PARTICIPANTID

#ENV=$PARTICIPANTID-$ENV_ORIGINAL
#SM_CP_NS=$PARTICIPANTID-$SM_CP_NS_ORIGINAL

#ISTIO_INGRESS_ROUTE_URL=$(oc get route istio-ingressgateway -o jsonpath='{.spec.host}' -n $SM_CP_NS)


#echo '---------------------------------------------------------------------------'
#echo 'Environemnt                                : '$ENV
#echo 'ServiceMesh Control Plane Namespace        : '$SM_CP_NS
#echo 'CLUSTER DOMAIN Name                        : '$DOMAIN_NAME
#echo 'PREFIX                                     : '$PREFIX
#echo 'Remote SMCP Route Name (when NO DNS)       : '$ISTIO_INGRESS_ROUTE_URL
#echo '---------------------------------------------------------------------------'

#sleep 10




echo 
echo "Update VirtualMachine CRs to include in the mesh by injecting Istio and Jaeger Agent sidecars to components"
echo "---------------------------------------------------------------------------------"
echo

#oc rollout pause deployment/control -n $ENV-travel-control
#oc patch deployment/control -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n $ENV-travel-control
#oc rollout resume deployment/control -n $ENV-travel-control
#oc patch deployment/control -p '{"metadata":{"annotations":{"sidecar.jaegertracing.io/inject": "'${PARTICIPANTID}-jaeger-small-production'"}}}' -n $ENV-travel-control
oc patch VirtualMachine/control-vm --type=merge -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n travel-control
oc delete pods -l vm.kubevirt.io/name=control-vm -n travel-control


#echo
#echo
#echo "Apply initial Istio Configs to Route external Traffic via Service Mesh Ingress"
#echo "---------------------------------------------------------------------------------"

#echo "Service Mesh Ingress Gateway Route"

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
    - istio-ingressgateway-istio-system.apps.cluster-9qw64.dynamic.redhatworkshops.io
  gateways:
    - istio-system/control-gateway
  http:
    - route:
        - destination:
            host: control.travel-control.svc.cluster.local
            subset: v1
          weight: 100"|oc apply -f -          
          
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
  host: control.travel-control.svc.cluster.local
  subsets:
    - labels:
        version: v1
      name: v1"|oc apply -f -       
#echo
#echo
#echo

#sleep 5


#oc get pods -n travel-control
#echo
#echo "----------------------------------------------"
#echo
#oc get pods -n $ENV-travel-portal
