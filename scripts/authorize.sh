#!/usr/bin/env bash

# takes token parameter and creates a tmp kubeconfig  
USER=$(oc whoami)
echo "USER = $USER"
NS=$(echo "$USER" | cut -d ":" -f 3)
if [ -z $NS ];
  NS=$USER-tenant
fi 
 
echo $NS=$NS


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
    namespace: $NS
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
 
  