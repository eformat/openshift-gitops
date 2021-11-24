#!/bin/bash

ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"/

export GITOPS_NAMESPACES=labs-ci-cd,ateam-ci-cd

echo 
echo "Installing the OpenShift GitOps Operator Subscription and Cluster RBAC:"
oc apply -k openshift-gitops/cluster
oc apply -f openshift-gitops/cluster/subscription-openshift-gitops.yaml

echo
echo "Waiting for CRD's to exist"
while : ; do
  oc get crd argocds.argoproj.io applications.argoproj.io appprojects.argoproj.io
  if [ $? -eq 0 ]; then
    break;
  fi
  sleep 5
done

echo 
echo "Deploying OpenShift Team ArgoCDs:"
oc apply -k .
