# CHIPtainer Example: Wifi Access Point

This is a Docker file for building a container that starts a wifi access point on wlan1.
There is an argument called "MY_ACCESS_POINT" you can define to change the name of the wifi network. By default, it is "myCHIPAccessPoint".

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
docker run --privileged --net=host -it ntc-registry.githost.io/nextthingco/chiptainer_wifi_access_point:master

```

You should now see a wifi access point called "myCHIPAccessPoint".