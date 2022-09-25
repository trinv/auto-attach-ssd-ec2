# auto-attach-ssd-ec2

## Create the directory that you want to mount SSD to:
example: 
```
# sudo mkdir -p /data/spda
```

## Create the script in the directory: ``/usr/local/sbin/``
```
nano /usr/local/sbin/auto-attach-ssd-ec2.sh
```
Add these lines into the script:
```
#!/bin/bash
sudo mkfs.ext4 -E nodiscard -m0 /dev/nvme1n1
sudo mount -o discard /dev/nvme1n1 /data/spda
sudo chown ubuntu:ubuntu /data/spda
```
Save & Exit 
## Chmod executed for the script:

```
# chmod 755 /usr/local/sbin/auto-attach-ssd-ec2.sh

```
Template file: [auto-attach-ssd-ec2.sh](https://github.com/trinv/auto-attach-ssd-ec2/blob/main/auto-attach-ssd-ec2.sh)
## Run to test
```
# /usr/local/sbin/auto-attach-ssd-ec2.sh
```
## Output:
```
Creating filesystem with 18310546 4k blocks and 4579328 inodes
Filesystem UUID: c8d482c1-add8-48c3-82c1-0737744baea5
Superblock backups stored on blocks:
        32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632, 2654208,
        4096000, 7962624, 11239424

Allocating group tables: done
Writing inode tables: done

```

```
# df -lTh

/dev/nvme1n1   ext4       69G   53M   69G   1% /data/spda
```
## Setup the script start with Boot OS:

```
# nano /etc/systemd/system/auto-attach-ssd.service
```
Template file: [auto-attach-ssd.service](https://github.com/trinv/auto-attach-ssd-ec2/blob/main/auto-attach-ssd.service)
```
[Unit]
After=network.target

[Service]
ExecStart=/usr/local/sbin/auto-attach-ssd-ec2.sh

[Install]
WantedBy=default.target
```
Save & Exit

## Reload systemd & Enable auto-attach-ssd.service to start with Boot OS:
```
# systemctl daemon-reload
# systemctl enable auto-attach-ssd.service
```
```
Output:
Created symlink /etc/systemd/system/default.target.wants/auto-attach-ssd.service → /etc/systemd/system/auto-attach-ssd.service.
```

## ```# reboot```
