#!/bin/bash -v
sudo apt-get update
sudo apt-get install unzip
sudo apt-get install libwww-perl libdatetime-perl
cd /opt
sudo curl http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip -O
sudo unzip CloudWatchMonitoringScripts-1.2.1.zip
sudo rm CloudWatchMonitoringScripts-1.2.1.zip
echo "*/5 * * * * /opt/aws-scripts-mon/mon-put-instance-data.pl --mem-util --mem-used --mem-avail --disk-space-util --disk-space-used --disk-space-avail --disk-path=/ --from-cron --verbose" >> userdata_cron
sudo crontab userdata_cron
sudo rm userdata_cron
