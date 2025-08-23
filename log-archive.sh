#!/bin/bash

LOG_DIR=$1
TIMESTAMP=$(date '+%Y%m%d_%H%M%S')
ARCHIVE_TO="/home/archives" 
ARCHIVE_NAME="logs_archive_${TIMESTAMP}.tar.gz"
LOG_FILE="archive.log"


if [ -z "$LOG_DIR" ]; then
    echo "You must specify the directory you want to archive: ./log-archive.sh <log-directory>"
    exit 1
fi

if [ ! -d "$LOG_DIR" ]; then
    echo "Directory $LOG_DIR not found"
    exit 1
fi

if [ ! -d "$ARCHIVE_TO" ]; then
    mkdir -p "$ARCHIVE_TO"
    echo "Created directory: $ARCHIVE_TO"
fi

tar -czf "$ARCHIVE_TO/$ARCHIVE_NAME" -C "$LOG_DIR" .

if [ $? -eq 0 ]; then
    echo "Logs archived successfully: $ARCHIVE_TO/$ARCHIVE_NAME"
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] Archive created: $ARCHIVE_NAME" >> "$ARCHIVE_TO/$LOG_FILE"
else
    echo "Logs error"
    exit 1
fi
