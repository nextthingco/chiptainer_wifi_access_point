# CHIPtainer Example: Wifi Access Point

This is a Docker file for building a container that starts a wifi access point on wlan1.

You must run this container from a CHIP that has Docker installed. To begin, log in to the NTC Docker account:

```
docker login ntc-registry.githost.io
```

Then download the latest image:

```
docker pull ntc-registry.githost.io/nextthingco/chiptainer_wifi_access_point:master
```

Now run the Docker container, allowing access to the network interface.

```
docker run --privileged --net=host -it ntc-registry.githost.io/nextthingco/chiptainer_wifi_access_point:master /bin/sh
```

Now issue these commands to start the access point:

```
ifconfig wlan1 172.20.0.1
dnsmasq -C /etc/dnsmasq.d/access_point.conf
hostapd /etc/hostapd/hostapd.conf
```

You should now see a wifi access point called "myCHIPAccessPoint".