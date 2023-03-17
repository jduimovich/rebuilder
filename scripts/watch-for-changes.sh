#!/usr/bin/env bash
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

declare -A COMPONENTS 
COMPONENTS=()  
declare -A REBUILDS 
REBUILDS=() 
function initComponentsList() { 
    NAMES=$(kubectl get components -o=name)
    for c in $NAMES
    do
        GITREPO=$(kubectl get $c -o yaml | yq .spec.source.git.url) 
        SHORTNAME=$(basename $c)
        HEAD_TAG=$(git ls-remote  $GITREPO HEAD |  cut -f 1)   
        CURRENT="${COMPONENTS[$SHORTNAME]}" 
        if [ "$CURRENT" = "$HEAD_TAG" ]; then 
                OP="No Changes"
        else 
            COMPONENTS["$SHORTNAME"]=$HEAD_TAG  
            if [ -z $CURRENT  ]; then
                OP="Init"
                BUILDIT=
            else  
                OP="Rebuild"
                BUILDIT="${REBUILDS[$SHORTNAME]}" 
                REBUILDS["$SHORTNAME"]="$BUILDIT $HEAD_TAG"
                BUILDIT="${REBUILDS[$SHORTNAME]}"  
                $SCRIPTDIR/rebuild-component.sh $c
            fi 
        fi 
        printf "$SHORTNAME: $GITREPO ($OP)\n\tTag: $HEAD_TAG\n"
        printf "Builds $BUILDIT\n"
    done 
}
 
echo "Initialize Tags" 
initComponentsList
while true 
do     
    echo "Monitoring Changes" 
    $SCRIPTDIR/show-rate-limit.sh | yq .rate 
    initComponentsList 
    for i in {10..1}
    do
        sleep 2
        echo -n $i.
    done
done