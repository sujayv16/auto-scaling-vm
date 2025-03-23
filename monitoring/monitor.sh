#!/bin/bash

THRESHOLD=75
INSTANCE_GROUP="instance-group-1"
REGION="us-central1"
LOG_FILE="/var/log/monitor.log"
SLEEP_INTERVAL=10  # Interval for checking resource usage

# Ensure gcloud is authenticated
gcloud auth login --quiet

echo "Starting Resource Monitor..." | tee -a $LOG_FILE
echo "Monitoring CPU Usage for Auto-Scaling Trigger" | tee -a $LOG_FILE

while true; do
    CPU_USAGE=$(mpstat 1 1 | awk '/Average:/ {print 100 - $NF}')
    echo "$(date) - CPU Usage: $CPU_USAGE%" | tee -a $LOG_FILE

    if (( $(echo "$CPU_USAGE > $THRESHOLD" | bc -l) )); then
        echo "$(date) - High CPU Usage detected! Initiating auto-scaling..." | tee -a $LOG_FILE
        gcloud compute instance-groups managed resize $INSTANCE_GROUP --region=$REGION --size=2
        sleep 60  # Cooldown period before next check
    else
        echo "$(date) - CPU usage normal." | tee -a $LOG_FILE
    fi
    
    sleep $SLEEP_INTERVAL  # Monitor every 10 seconds
done

