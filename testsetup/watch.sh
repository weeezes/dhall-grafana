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

#| xargs -I{} /bin/bash -c '| grep NoOp | uniq' | xargs -I{} $reloader {}

fswatch --batch-marker --event="Updated" $watch_file | while read num; do
  if echo $num | grep -q NoOp; then
    fswatch -1 --batch-marker $watch_file | grep NoOp | xargs -I{} $reloader {}
  fi
done
