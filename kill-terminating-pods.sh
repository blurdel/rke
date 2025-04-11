#!/bin/bash

# Delete Terminating pods
NAMESPACE=common;

pods="$(kubectl get pods -n ${NAMESPACE} | grep Terminating | awk '{print $1}')"
for pod in pods; do
	kubectl delete pod "${pod}" -n "${NAMESPACE}" --force --grace-period=0
done
