SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

while true
do
  if [ -f /tmp/local-kc  ]; then 
    break
  fi 
  echo "Waiting for kubeconfig"
  sleep 10
done  
if [ -f /tmp/rebuilder-poll-pid  ]; then
    PID=$(cat /tmp/rebuilder-poll-pid)
    kill -9 $PID
fi 
bash $SCRIPTDIR/watch-for-changes.sh &
PID=$!
echo $PID >  /tmp/rebuilder-poll-pid 
echo "BG Thread in $PID in file  /tmp/rebuilder-poll-pid " 
echo "done setup Polling in background"