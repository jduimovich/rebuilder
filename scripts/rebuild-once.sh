#!/usr/bin/env bash
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
NAMES=$(kubectl get components -o=name)
for c in $NAMES
do
     $SCRIPTDIR/rebuild-component.sh $c
done 

  