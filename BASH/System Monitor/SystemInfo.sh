#!/bin/bash

# Function to get CPU usage
get_cpu_usage() {
  cpu_percentage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}')
  echo "CPU Usage: $cpu_percentage%"
}

# Function to get memory usage
get_memory_usage() {
  memory_percentage=$(free | grep Mem | awk '{print ($3 / $2) * 100}')
  echo "Memory Usage: $memory_percentage%"
}

# Function to get disk space
get_disk_space() {
  disk_space=$(df -h | awk '$NF == "/" {print $5}')
  echo "Disk Space: $disk_space used"
}

# Function to get network statistics
get_network_stats() {
  received_bytes=$(cat /sys/class/net/*/statistics/rx_bytes | awk '{sum += $1} END {print sum}')
  transmitted_bytes=$(cat /sys/class/net/*/statistics/tx_bytes | awk '{sum += $1} END {print sum}')
  echo "Network Statistics:"
  echo "  Received Bytes: $received_bytes"
  echo "  Transmitted Bytes: $transmitted_bytes"
}

# Main function
main() {
  clear
  echo "System Monitoring:"
  echo "------------------"

  while true; do
    get_cpu_usage
    get_memory_usage
    get_disk_space
    get_network_stats

    sleep 1  # Update every 3 seconds
    clear
    echo "System Monitoring:"
    echo "------------------"
  done
}

# Run the main function
main

