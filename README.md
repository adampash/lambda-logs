# lambda-logs

A simple CLI script to pull Report logs from AWS CloudWatch for Lambda functions.

## Usage

```bash
./get-logs.sh name-of-lambda-function [max-items=100]

#  max-items: the number of log streams to pull from AWS. This will ultimately
#  determine the number of logs in the output. Default value is 100.
```

Logs will look something like:

```
REPORT RequestId: 706f87a3-d6b9-11e6-95d8-2be4fec37c55	Duration: 995.78 ms	Billed Duration: 1000 ms 	Memory Size: 1024 MB	Max Memory Used: 83 MB

```

This script assumes you have the aws-cli installed (`pip install awscli`),
[jq](https://stedolan.github.io/jq/) installed, and you're pulling logs from a
function associated with what you've configured as your default AWS account.

If you'd prefer JSON output, you can run the following:

```bash
./logs-to-json.sh path-to-log-file > report-logs.json
```

JSON logs will look something like:

```json
[
  {
    "id": "706f87a3-d6b9-11e6-95d8-2be4fec37c55",
    "duration": "995.78",
    "billedDuration": "1000",
    "memorySize": "1024 MB",
    "maxMemoryUsed": "83 MB"
  }
]
```
