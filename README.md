## OpenShift GitOps

- OpenShift GitOps Operator v1.3.1+
- OpenShift v4.8,v4.9+

Deploy multiple Team ArgoCD GitOps instances that have cluster admin privilege using OpenShift GitOps Operator.

Define the team deployments projects and add a Kustomize `overlay` to match in the `openshift-gitops/overlays` folder.

We tell the operator where we want to deploy cluster scoped ArgoCD GitOps instances.
```bash
export GITOPS_NAMESPACES=labs-ci-cd,ateam-ci-cd
```

Deploy the Cluster resources and GitOps operator.
```bash
oc apply -k openshift-gitops/cluster
sed "s/GITOPS_NAMESPACES/$GITOPS_NAMESPACES/" openshift-gitops/cluster/subscription-openshift-gitops.yaml | oc apply -f-
```

Deploy Team ArgoCD instances
```
oc apply -k .
```

## Helper Scripts

Deploy GitOps
```bash
./bootstrap-cluster.sh
```

Deploy some test Apps including ones with CRD's
```bash
./test-apps.sh
```

Delete it all
```bash
./delete.sh
```
