#!/bin/bash


echo 
echo "Update VirtualMachine CRs to include in the mesh by injecting Istio and Jaeger Agent sidecars to components"
echo "---------------------------------------------------------------------------------"
echo

oc patch VirtualMachine/travel-control-vm-pool-0 --type=merge -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n travel-control
oc delete pods -l vm.kubevirt.io/name=travel-control-vm-pool-0 -n travel-control
