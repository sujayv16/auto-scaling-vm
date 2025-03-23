#!/bin/bash

INSTANCE_GROUP="instance-group-1"
ZONE="us-central1-c"

echo "Configuring auto-scaling for $INSTANCE_GROUP..."

gcloud compute instance-groups managed update $INSTANCE_GROUP \
  --zone=$ZONE \
  --cool-down-period=60 \
  --max-num-replicas=5 \
  --min-num-replicas=1 \
  --target-cpu-utilization=0.75

echo "Auto-scaling configuration updated successfully!"
