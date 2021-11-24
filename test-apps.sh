#!/bin/bash

oc -n ateam-ci-cd apply -f - <<'EOF'
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: welcome
spec:
  destination:
    namespace: welcome-ateam
    server: 'https://kubernetes.default.svc'
  source:
    path: argocd/base
    repoURL: https://github.com/eformat/welcome
    targetRevision: master
  project: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      validate: true
    syncOptions:
    - CreateNamespace=true
  ignoreDifferences:
  - group: apps.openshift.io
    jsonPointers:
    - /spec/template/spec/containers/0/image
    - /spec/triggers/0/imageChangeParams/lastTriggeredImage
    kind: DeploymentConfig
EOF

oc -n labs-ci-cd apply -f - <<'EOF'
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: welcome
spec:
  destination:
    namespace: welcome-labs
    server: 'https://kubernetes.default.svc'
  source:
    path: argocd/base
    repoURL: https://github.com/eformat/welcome
    targetRevision: master
  project: default
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      validate: true
    syncOptions:
    - CreateNamespace=true
  ignoreDifferences:
  - group: apps.openshift.io
    jsonPointers:
    - /spec/template/spec/containers/0/image
    - /spec/triggers/0/imageChangeParams/lastTriggeredImage
    kind: DeploymentConfig
EOF

oc -n labs-ci-cd apply -f - <<'EOF'
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: sealed-secrets
spec:
  destination:
    namespace: sealed-secrets
    server: 'https://kubernetes.default.svc'
  project: default
  source:
    path: sealed-secrets
    repoURL: 'https://github.com/eformat/argocd.git'
    targetRevision: HEAD
  syncPolicy:
    automated:
      prune: true
      selfHeal: true
      validate: true
    syncOptions:
    - CreateNamespace=true
EOF
