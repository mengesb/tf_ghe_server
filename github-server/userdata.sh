#!/bin/bash -v
curl -O https://bootstrap.pypa.io/get-pip.py
sudo python get-pip.py
sudo pip install awscli
cd ~admin
git clone https://github.com/moomindani/aws-mon-linux.git
echo "*/5 * * * * ~admin/aws-mon-linux/aws-mon.sh --all-items --diskpath=/ --from-cron --verbose" >> userdata_cron
sudo crontab userdata_cron
sudo rm userdata_cron
