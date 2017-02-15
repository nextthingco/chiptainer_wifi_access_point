# Base off the Docker container that includes Alpine for installing packages.
FROM ntc-registry.githost.io/nextthingco/chiptainer_alpine

COPY doStartup.sh /root/doStartup.sh

RUN apk update && apk add dnsmasq && apk add hostapd && apk add nano && apk add openrc && apk add dhcpcd && \
	mkdir -p  "/etc/dnsmasq.d" && \
	printf "interface=wlan1\nbind-interfaces\nexcept-interface=wlan0,lo\ndhcp-range=172.20.0.100,172.20.0.250,1h" > /etc/dnsmasq.d/access_point.conf && \

	echo "START" && \
	printf "auto lo\niface lo inet loopback\n\nsource-directory /etc/network/interfaces.d\nauto wlan1\niface wlan1 inet static\n  address 172.20.0.1\n  netmask 255.255.255.0" > /etc/network/interfaces && \

	#/etc/init.d/dnsmasq restart && \

	mkdir -p "/etc/hostapd/" && \
	printf "interface=wlan1\ndriver=nl80211\nssid=myCHIPAccessPoint\nchannel=1\nctrl_interface=/var/run/hostapd" > /etc/hostapd/hostapd.conf


CMD ["/bin/sh","-c","/root/doStartup.sh"]
