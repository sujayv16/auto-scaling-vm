#!/bin/bash

echo "Simulating high CPU usage for 120 seconds..."
stress --cpu 4 --timeout 120
echo "Stress test completed!"
