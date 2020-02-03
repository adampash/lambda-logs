#!/bin/bash

if [ -z "$1" ]; then
  echo "
  Usage:

    ./get-logs.sh name-of-lambda-function [max-items=100]

  max-items: the number of log streams to pull from AWS. This will ultimately
  determine the number of logs in the output. Default value is 100.
"

else
  # default max items to 100
  MAX_ITEMS=${2:-$(echo 100)}
  echo Fetching $MAX_ITEMS log streams for $1
  # get array of log streams
  echo "
...
  "
  LOG_STREAM_NAMES=$(aws logs describe-log-streams --log-group-name /aws/lambda/$1 \
    --max-items $MAX_ITEMS \
    | jq .logStreams \
    | jq -r ".[] | .logStreamName")

  echo "Done
  "

  # iterate over array of log streams
  for row in $LOG_STREAM_NAMES; do
    echo Fetching logs for log stream: $row
    # fetch logs for stream and
    # filter reports out of log stream
    IFS=$'\n'
    EVENTS="$EVENTS$(aws logs get-log-events --log-group-name /aws/lambda/$1 \
      --log-stream-name $row --output json | jq .events | jq -r '.[] | .message' | grep REPORT)"
  done

  dt=$(date '+%m-%d-%Y-%H-%M-%S')
  for event in $EVENTS; do
    echo $event >> report-events-$dt.log
  done

  echo "
Done. All REPORT logs written to report-events-$dt.log
  "

fi

