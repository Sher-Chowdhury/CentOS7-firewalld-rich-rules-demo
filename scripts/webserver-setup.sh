#!/usr/bin/env bash
# exit 0
set -ex

echo '##########################################################################'
echo '################## About to run source-rpms.sh script ####################'
echo '##########################################################################'


echo '10.0.0.0/24 via 192.168.10.100' >> /etc/sysconfig/network-scripts/route-enp0s8

systemctl restart network

exit 0


# perform tests with:
# ping -c 3 10.0.0.11
# ssh 10.0.0.11
# traceroute 10.0.0.11