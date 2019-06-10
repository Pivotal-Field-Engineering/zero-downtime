#!/bin/bash

SCRIPTBASEDIR=$(dirname "$0")
APP_SINGLE_URL="$1"
echo `date -u` "Start polling an app end point"

#running in background infinetely
while true
do
  #check the condition
  if [ -f /tmp/stop-inf-loop ];
  then
    break
  else
    $SCRIPTBASEDIR/check-scripts/check-app-curl.sh $APP_SINGLE_URL FALSE
    sleep 0.5
  fi
done

echo `date -u` "Finished polling an app end point"
