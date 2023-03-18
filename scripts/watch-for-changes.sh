#!/usr/bin/env bash
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

declare -A COMPONENTS 
COMPONENTS=()  
declare -A REBUILDS 
REBUILDS=() 

function initComponentsList() {
    if [ -f /tmp/local-kc  ]; then
        export KUBECONFIG=/tmp/local-kc 
    fi 
    NAMES=$(kubectl get components -o=name)
    for c in $NAMES
    do
        GITREPO=$(kubectl get $c -o jsonpath={.spec.source.git.url}) 
        SHORTNAME=$(basename $c)
        HEAD_TAG=$(git ls-remote  $GITREPO HEAD |  cut -f 1)   
        CURRENT="${COMPONENTS[$SHORTNAME]}" 
        if [ "$CURRENT" = "$HEAD_TAG" ]; then 
                OP="No Changes"
        else 
            COMPONENTS["$SHORTNAME"]=$HEAD_TAG  
            if [ -z $CURRENT  ]; then
                OP="Init"
                BUILDIT=0
            else  
                OP="Rebuild"
                BUILDIT="${REBUILDS[$SHORTNAME]}" 
                let BUILDIT++
                $SCRIPTDIR/rebuild-component.sh $c
            fi
            REBUILDS["$SHORTNAME"]="$BUILDIT"   
        fi 
        printf "$SHORTNAME: $GITREPO ($OP)\n\tTag $HEAD_TAG Builds: $BUILDIT\n"
    done 
}
  
initComponentsList
while true 
do       
    initComponentsList 
    for i in {10..1}
    do
        sleep 1
        echo -n $i.
    done
done