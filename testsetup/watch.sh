#!/bin/bash

watch_file=$1

if [ -z $watch_file ]; then
  echo "File name to watch required"
  exit 1
fi

reloader=""
case "$OSTYPE" in
  solaris*) 
	echo "Not supported: $OSTYPE"
	exit 1 ;;
  darwin*)  
	echo "Not supported: $OSTYPE"
	exit 1 ;;
  linux*)   reloader="./reload-linux.sh" ;;
  bsd*)     
	echo "Not supported: $OSTYPE"
	exit 1 ;;
  msys*)    
	echo "Not supported: $OSTYPE"
	exit 1 ;;
  *)    
	echo "Not supported: $OSTYPE"
	exit 1 ;;
esac

fswatch --batch-marker --event="Updated" $watch_file | while read line; do
  if echo $line | grep -q NoOp; then
    dashboard="$(jq -M -c 'del(.id)' $watch_file)"
    uid=$(echo $dashboard | jq -r '.uid')
    payload=$(echo $dashboard | jq -r -c -M '{ "dashboard": ., "folderId": 0, "overwrite": true }')

    echo "Updating..."
    post_response=$(curl -XPOST -H "Content-Type: application/json" -H "Accept: application/json" -d "$payload" http://admin:admin@localhost:3000/api/dashboards/db)
    response=$(curl -H "Content-Type: application/json" -H "Accept: application/json" http://admin:admin@localhost:3000/api/dashboards/uid/$uid)
    result=$(echo $response | jq -r -c '.dashboard')

    if [ -n "$result" ]; then
      $reloader
    fi
  fi
done
