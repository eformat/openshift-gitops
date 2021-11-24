#!/bin/bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/

oc delete -k .
oc delete -f openshift-gitops/cluster/subscription-openshift-gitops.yaml
oc delete -k openshift-gitops/cluster
