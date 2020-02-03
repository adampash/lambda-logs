#!/bin/bash

if [ -z "$1" ]; then
  echo "
  Usage:

    ./logs-to-json.sh path-to-log-file.log

"
else
  cat $1  | jq --raw-input --slurp 'split("\n") | map(split("\t")) | .[0:-1] |
    map( { "id": .[0] | split(": ") | .[1], "duration": .[1] | split(" ") |
    .[1], "billedDuration": .[2] | split(" ") | .[2], "memorySize": .[3] |
    split(": ") | .[1], "maxMemoryUsed": .[4] | split(": ") | .[1] } )'
fi

