## OpenShift GitOps

- OpenShift GitOps Operator v1.3.1+
- OpenShift v4.8,v4.9+

Deploy multiple Team ArgoCD GitOps instances that have cluster admin privilege using OpenShift GitOps Operator.

Define the team deployments projects and add a Kustomize `overlay` to match in the `openshift-gitops/overlays` folder.

Deploy the GitOps operator. We tell the operator where we want to deploy cluster scoped ArgoCD GitOps instances.
```bash
export GITOPS_NAMESPACES=labs-ci-cd,ateam-ci-cd
```

Deploy the Cluster resources
```bash
oc apply -k openshift-gitops/cluster
oc apply -f openshift-gitops/cluster/subscription-openshift-gitops.yaml
```

Team ArgoCD instances
```
oc apply -k .
```
