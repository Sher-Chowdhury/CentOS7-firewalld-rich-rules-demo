#!/usr/bin/env bash
# exit 0
set -ex

echo '##########################################################################'
echo '################## About to run webserver-rpms.sh script ####################'
echo '##########################################################################'


yum install -y httpd
systemctl start httpd
systemctl enable httpd



exit 0
