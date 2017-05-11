# Base off the Docker container that includes Alpine for installing packages.
FROM ntc-registry.githost.io/nextthingco/chiptainer_alpine

LABEL architecture="ARMv7"

# Set an argument for the default name of our access point.
# Users can define this argument during the Docker build process if they wish.
ARG ACCESS_POINT_NAME="myCHIPAccessPoint"

RUN apk add --update --no-cache dnsmasq hostapd openrc dhcpcd && \
	
	# Configure the various DNS and network interface settings.
	mkdir -p  "/accesspoint_conf" && \
	printf "interface=wlan1\nbind-interfaces\nexcept-interface=wlan0,lo\ndhcp-range=172.20.0.100,172.20.0.250,1h" > /accesspoint_conf/access_point.conf && \
	printf "auto lo\niface lo inet loopback\n\nsource-directory /etc/network/interfaces.d\nauto wlan1\niface wlan1 inet static\n  address 172.20.0.1\n  netmask 255.255.255.0" > /etc/network/interfaces && \
	printf "interface=wlan1\ndriver=nl80211\nssid=$ACCESS_POINT_NAME\nchannel=1\nctrl_interface=/var/run/hostapd" > /accesspoint_conf/hostapd.conf

ENTRYPOINT ifconfig wlan1 172.20.0.1 && \
	dnsmasq -C /accesspoint_conf/access_point.conf && \
	hostapd -B /accesspoint_conf/hostapd.conf && \
	echo "***********************************" && \
	echo "Access point is now up and running!" && \
	echo "***********************************" && \
	/bin/sh
