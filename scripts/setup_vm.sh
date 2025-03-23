#!/bin/bash

echo "Updating system..."
sudo apt update && sudo apt upgrade -y

echo "Installing required packages..."
sudo apt install htop sysstat stress curl git -y
sudo apt install prometheus-node-exporter -y

echo "Enabling monitoring services..."
sudo systemctl enable sysstat
sudo systemctl start sysstat

echo "Setup complete!"
