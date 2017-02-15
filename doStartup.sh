#!/bin/sh

ifconfig wlan1 172.20.0.1
dnsmasq -C /etc/dnsmasq.d/access_point.conf
hostapd /etc/hostapd/hostapd.conf
