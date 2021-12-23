#!/bin/bash
sudo mkfs.ext4 -E nodiscard -m0 /dev/nvme1n1
sudo mount -o discard /dev/nvme1n1 /data/spda
sudo chown ubuntu:ubuntu /data/spda
