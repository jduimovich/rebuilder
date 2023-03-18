SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

bash $SCRIPTDIR/watch-for-changes.sh &

echo "Polling in background"