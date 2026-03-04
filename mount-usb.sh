#!/bin/bash
set -euo pipefail

MOUNT_POINT="/mnt/usb"

# FINDING USB DISK
DISK=$(lsblk -dno NAME,TRAN | awk '$2=="usb" {print $1; exit}')

# FINDING FIRST PARTITION
PART=$(lsblk -lnpo NAME,TYPE /dev/$DISK | awk '$2=="part" {print $1; exit}')

# MOUNT USB
sudo mkdir -p $MOUNT_POINT
sudo mount $PART $MOUNT_POINT

echo "The USB drive has been mounted at ${MOUNT_POINT}."
