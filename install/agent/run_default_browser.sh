#!/bin/bash

LAST_STATE=""

check_log_size() {
    local log_file="$1"
    local max_size=10485760  # 10 MB in bytes

    if [ -f "$log_file" ]; then
        size=$(stat -f%z "$log_file")
        if [ "$size" -ge "$max_size" ]; then
            echo "$(date '+%Y-%m-%d %H:%M:%S') Log $log_file exceeds 10MB ($size bytes), deleting..." >> /tmp/defaultbrowser.out
            rm "$log_file"
        fi
    fi
}

while true; do
    check_log_size "/tmp/defaultbrowser.out"
    check_log_size "/tmp/defaultbrowser.shortcut.err"

    CURRENT_STATE=$(pmset -g batt | grep -oE "(AC|Battery) Power")
    
    if [ "$CURRENT_STATE" != "$LAST_STATE" ]; then
        echo "$(date '+%Y-%m-%d %H:%M:%S') Power state changed: $CURRENT_STATE" >> /tmp/defaultbrowser.out
        if [ "$CURRENT_STATE" = "AC Power" ]; then
            shortcuts run "default-browser" 2>> /tmp/defaultbrowser.shortcut.err
        else
            shortcuts run "default-browser" 2>> /tmp/defaultbrowser.shortcut.err
        fi
        LAST_STATE="$CURRENT_STATE"
    fi

    sleep 3
done