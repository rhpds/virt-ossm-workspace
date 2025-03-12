#!/bin/bash

#ENV_ORIGINAL=$1
#SM_CP_NS_ORIGINAL=$2
#PARTICIPANTID=$3

#ENV=$PARTICIPANTID-$ENV_ORIGINAL
#SM_CP_NS=$PARTICIPANTID-$SM_CP_NS_ORIGINAL

#ISTIO_INGRESS_ROUTE_URL=$(oc get route istio-ingressgateway -o jsonpath='{.spec.host}' -n $SM_CP_NS)

#echo '---------------------------------------------------------------------------'
#echo 'Environment                                : '$ENV
#echo 'ServiceMesh Control Plane Namespace        : '$SM_CP_NS
#echo 'Remote SMCP Route Name (when NO DNS)       : '$ISTIO_INGRESS_ROUTE_URL
#echo '---------------------------------------------------------------------------'

sleep 10


echo
echo "Update VirtualMachine CRs to include in the mesh by injecting Istio and Jaeger Agent sidecars to components"
echo "-----------------------------------------------------------------------------------------------------------------------"
echo


#oc rollout pause VirtualMachine/cars-vm -n travel-agency
#oc patch deployment/cars-v1 -p '{"metadata":{"annotations":{"sidecar.jaegertracing.io/inject": "'${PARTICIPANTID}-jaeger-small-production'"}}}' -n travel-agency
#oc rollout resume deployment/cars-v1 -n travel-agency
oc patch VirtualMachine/cars-vm --type merge -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n travel-agency
oc delete pods -l vm.kubevirt.io/name=cars-vm

#oc rollout pause deployment/discounts-v1 -n travel-agency
#oc patch deployment/discounts-v1 -p '{"metadata":{"annotations":{"sidecar.jaegertracing.io/inject": "'${PARTICIPANTID}-jaeger-small-production'"}}}' -n travel-agency
#oc rollout resume deployment/discounts-v1 -n travel-agency
oc patch VirtualMachine/discounts-vm --type merge -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n travel-agency
oc delete pods -l vm.kubevirt.io/name=discounts-vm

#oc rollout pause deployment/flights-v1 -n travel-agency
#oc patch deployment/flights-v1 -p '{"metadata":{"annotations":{"sidecar.jaegertracing.io/inject": "'${PARTICIPANTID}-jaeger-small-production'"}}}' -n travel-agency
#oc rollout resume deployment/flights-v1 -n travel-agency
oc patch VirtualMachine/flights-vm --type merge -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n travel-agency
oc delete pods -l vm.kubevirt.io/name=flights-vm

#oc rollout pause deployment/hotels-v1 -n travel-agency
#oc patch deployment/hotels-v1 -p '{"metadata":{"annotations":{"sidecar.jaegertracing.io/inject": "'${PARTICIPANTID}-jaeger-small-production'"}}}' -n travel-agency
#oc rollout resume deployment/hotels-v1 -n travel-agency
oc patch VirtualMachine/hotels-vm --type merge -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n travel-agency
oc delete pods -l vm.kubevirt.io/name=hotels-vm

#oc rollout pause deployment/insurances-v1 -n travel-agency
#oc patch deployment/insurances-v1 -p '{"metadata":{"annotations":{"sidecar.jaegertracing.io/inject": "'${PARTICIPANTID}-jaeger-small-production'"}}}' -n travel-agency
#oc rollout resume deployment/insurances-v1 -n travel-agency
oc patch VirtualMachine/insurances-vm --type merge -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n travel-agency
oc delete pods -l vm.kubevirt.io/name=insurances-vm

#oc rollout pause deployment/mysqldb-v1 -n travel-agency
#oc patch deployment/mysqldb-v1 -p '{"metadata":{"annotations":{"sidecar.jaegertracing.io/inject": "'${PARTICIPANTID}-jaeger-small-production'"}}}' -n travel-agency
#oc rollout resume deployment/mysqldb-v1 -n travel-agency
oc patch VirtualMachine/mysqldb-vm --type merge -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n travel-agency
oc delete pods -l vm.kubevirt.io/name=mysqldb-vm

#oc rollout pause deployment/travels-v1 -n travel-agency
#oc patch deployment/travels-v1 -p '{"metadata":{"annotations":{"sidecar.jaegertracing.io/inject": "'${PARTICIPANTID}-jaeger-small-production'"}}}' -n travel-agency
#oc rollout resume deployment/travels-v1 -n travel-agency
oc patch VirtualMachine/travels-vm --type merge -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n travel-agency
oc delete pods -l vm.kubevirt.io/name=travels-vm

echo
echo
echo
sleep 5

oc get pods -n travel-agency
