#!/bin/bash
#
# 1. add /etc/network/interfaces.restore with fallback values
# 2. add to root crontab
#   */N * * * * /path/to/restore.sh
#   where N - some minutes (ex, 5)
# 3. reconfigure /etc/network/interfaces
# 4. if you have a problem wait for N minutes, than reboot server
#

NOW=`date '+%Y-%m-%d-%H-%M-%S'`

echo 'restored'
mkdir -p /root/interfaces

cp /etc/network/interfaces /root/interfaces/"${NOW}"-interfaces
cp -f /etc/network/interfaces.restore /etc/network/interfaces
