#!/bin/bash
set -euo pipefail

if [ $# -ne 1 ]; then
  echo "Usage: $0 <ssh key filename>"
  exit 1
fi

MOUNT_POINT="/mnt/usb"
FILENAME="$1"

# FINDING USB DISK
DISK=$(lsblk -dno NAME,TRAN | awk '$2=="usb" {print $1; exit}')

# FINDING FIRST PARTITION
PART=$(lsblk -lnpo NAME,TYPE /dev/$DISK | awk '$2=="part" {print $1; exit}')

# MOUNT USB
sudo mkdir -p $MOUNT_POINT
sudo mount $PART $MOUNT_POINT
echo
echo 'The USB drive has been mounted at /mnt/usb.'
echo

# GENERATE AND MOVE KEY
ssh-keygen -t ed25519 -C "$FILENAME" -f ~/.ssh/${FILENAME}
echo
sudo mv ~/.ssh/$FILENAME $MOUNT_POINT/$FILENAME
echo 'Generated ssh-key and moved it to /mnt/usb.'

cat ~/.ssh/${FILENAME}.pub >> ~/.ssh/authorized_keys
echo "${FILENAME}.pub has been appended to authorized_keys."

rm -rf ~/.ssh/${FILENAME}.pub
echo "${FILENAME}.pub has been deleted."
echo

# UNMOUNT USB
sudo umount $MOUNT_POINT
echo 'The USB drive has been safely unmounted.'
echo

# ===== COPY usb_to_wsl.exe FILE =====

if [ -f ~/.ssh/usb_to_wsl.exe ]; then
  echo 'File usb_to_wsl.exe found in ~/.ssh.'
  echo 'Initiating copy of file usb_to_wsl.exe from ~/.ssh to USB drive...'
  echo
  echo 'The USB drive has been mounted at /mnt/usb.'
  sudo mount $PART $MOUNT_POINT
  echo 'Copying usb_to_wsl.exe to USB drive...'
  sudo cp ~/.ssh/usb_to_wsl.exe $MOUNT_POINT/
  sudo umount $MOUNT_POINT
  echo 'Copy completed. The USB drive has been safely umounted.'
  echo
  echo 'All tasks have been completed successfully.'
  echo
else
  echo 'File usb_to_wsl.exe not found in ~.ssh.'
  echo
fi

echo "===== NEXT STEP ====="
echo "Insert the USB drive into a Windows PC."
echo "Run usb_to_wsl.exe."
echo "The file will be automatically moved to the .ssh folder in WSL."
echo "Open PowerShell"
echo "Run: wsl.exe -d Ubuntu"
echo "Run: chmod 600 ~/.ssh/FILENAME"
echo
