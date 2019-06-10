#!/bin/bash

app_url=
debug=FALSE

if [ $# -gt 0 ]; then
	if [ "$1" != "" ]; then
	  app_url=$1
  fi
	if [ "$2" != "" ]; then
    debug=$2
  fi
else
    echo "Command line contains no arguments"
		exit 1
fi

tmp=`curl -kis ${app_url}`

HttpResponseCode=${tmp%%$'\n'*}
#echo $HttpResponseCode
#echo "<<<<<<<<<<<<<<<>>>>>>>>>>>>>>"
if [[ "$debug" = "TRUE" ]]; then
	echo `date -u`
	echo "$tmp"
	echo "==================================="
	echo "Apps URL: ${app_url}"
	echo "==================================="
fi

if [[ "$tmp" =~ ^HTTP.*200.* ]]; then
  #if [[ "$debug" = "TRUE" ]]; then
	echo `date -u` "The app endpoint ${app_url} is working. Code: " ${HttpResponseCode}
  #fi
else
	echo `date -u` "The app endpoint ${app_url} is DOWN! Error Code: " ${HttpResponseCode}
fi
