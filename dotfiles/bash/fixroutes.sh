#!/usr/bin/env bash
# add routes for ec2 ip blocks
wget -qO - https://ip-ranges.amazonaws.com/ip-ranges.json \
  |jt prefixes [ region % ] [ service % ] [ ip_prefix % ] \
  |grep us-east-1\\sEC2 |cut -f3 |sed 's@^\(.*\)$@ip route add \1 dev tun0@' \
  |sudo bash
  
# add default route for LAN
sudo ip route add default via $(route -n|grep ^0|grep -v tun|awk '{print $2}')
