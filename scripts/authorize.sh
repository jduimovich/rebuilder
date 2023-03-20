#!/usr/bin/env bash

# takes token parameter and creates a tmp kubeconfig 
cat <<EOF > /tmp/local-kc 
apiVersion: v1
clusters:   
- cluster: 
    insecure-skip-tls-verify: true
    server: https://kubernetes.default.svc
  name: local-cluster    
contexts:
- context:
    cluster: local-cluster
    namespace: user1-tenant
    user: kubeadmin/local-cluster
  name: local-context
current-context: local-context
kind: Config
preferences: {}
users:
- name: kubeadmin/local-cluster
  user:
    token: $1
EOF
 
  