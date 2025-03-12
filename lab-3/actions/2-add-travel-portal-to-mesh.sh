#!/bin/bash

echo 
echo "Add Deployments in the mesh by injecting Service Mesh and Jaeger Agent sidecars to components"
echo "---------------------------------------------------------------------------------"
echo


oc patch deployment/travels -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n travel-portal

oc patch deployment/viaggi -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n travel-portal

oc patch deployment/voyages -p '{"spec":{"template":{"metadata":{"annotations":{"sidecar.istio.io/inject": "true"}}}}}' -n travel-portal
