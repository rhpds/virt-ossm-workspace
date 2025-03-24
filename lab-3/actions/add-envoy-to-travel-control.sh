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

oc patch VirtualMachine/control-vm --type=merge -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n travel-control
oc delete pods -l vm.kubevirt.io/name=control-vm -n travel-control
