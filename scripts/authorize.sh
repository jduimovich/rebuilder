#!/usr/bin/env bash

SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sed s/FILL_TOKEN_IN/$1/g $SCRIPTDIR/config.template > /tmp/local-kc 
  