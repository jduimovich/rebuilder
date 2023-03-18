
RT=$(kubectl get routes rebuilder -o jsonpath={.spec.host})

echo "curl -k https://$RT/authorize?id=$(oc whoami --show-token)"

curl -k https://$RT/authorize?id=$(oc whoami --show-token)