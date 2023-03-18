#!/usr/bin/env bash
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
if [ -f /tmp/local-kc  ]; then
     export KUBECONFIG=/tmp/local-kc 
fi  
NAMES=$(kubectl get components -o=name)
for c in $NAMES
do
     $SCRIPTDIR/rebuild-component.sh $c
done 

  
  