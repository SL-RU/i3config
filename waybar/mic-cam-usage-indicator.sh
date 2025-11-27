#!/bin/bash

THRESHOLD=1

STATE_FILE="/tmp/webcam_timer_state"
modu="184320" # change this to fit a webcam module you have

if [ -f "$STATE_FILE" ]; then
    source "$STATE_FILE"
else
    start_time=0
    webcam_active=false
fi

webcam_status=$(lsmod | grep uvcvideo | head -n 1 | awk '{print $3}')
webcam_module=$(lsmod | grep uvcvideo | head -n 1 | awk '{print $2}')

webcam="⭕"
if [ "$webcam_status" == "1" ] && [ "$webcam_module" == "$modu" ]; then
    if [ "$webcam_active" == false ]; then
        start_time=$(date +%s)
        webcam_active=true
    else
        current_time=$(date +%s)
        elapsed_time=$((current_time - start_time))

        if [ "$elapsed_time" -ge "$THRESHOLD" ]; then
            webcam="📷"
        fi
    fi
else
    webcam_active=false
    start_time=0
fi

echo "start_time=$start_time" > "$STATE_FILE"
echo "webcam_active=$webcam_active" >> "$STATE_FILE"

# this path is specific to my card to show microphone usage
mic_status=$(cat /proc/asound/card3/pcm0c/sub0/status | head -n 1 | awk '{print $2}')

if [ "$mic_status" == "RUNNING" ]; then
    mic="🎤"
else
    mic="🔇"
fi

echo "$webcam $mic"
