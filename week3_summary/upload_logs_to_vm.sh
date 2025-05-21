#!/bin/bash

# USAGE:
# ./upload_logs_to_vm.sh <user@host> <local_folder> <remote_folder>

REMOTE="$1"
LOCAL_FOLDER="$2"
REMOTE_FOLDER="$3"

if [[ -z "$REMOTE" || -z "$LOCAL_FOLDER" || -z "$REMOTE_FOLDER" ]]; then
  echo "Usage: $0 <user@host> <local_folder> <remote_folder>"
  echo "Example: $0 azureuser@52.1.2.3 ./logs /home/azureuser/logs_target"
  exit 1
fi

if [[ ! -d "$LOCAL_FOLDER" ]]; then
  echo "Error: '$LOCAL_FOLDER' is not a valid local directory"
  exit 1
fi

LOCAL_FOLDER="${LOCAL_FOLDER%/}"

ssh "$REMOTE" "mkdir -p \"$REMOTE_FOLDER\""

echo "Uploading '$LOCAL_FOLDER/' to $REMOTE:$REMOTE_FOLDER ..."
rsync -avz --progress "$LOCAL_FOLDER/" "$REMOTE:$REMOTE_FOLDER/"

echo "Upload complete → $REMOTE:$REMOTE_FOLDER"
