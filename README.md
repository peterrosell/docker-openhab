Overview
========

Raspberry PI specifc Docker image for Openhab (1.7.1) running on Java 1.8.

Forked from craigham/docker-openhab

Updated to use hypriot/rpi-java as the base image for the raspberry pi.

Official DEMO Included
========

If you do not have a openHAB configuration yet, you can start this Docker without one. The official openHAB DEMO will be started. 

PULL
=======
```docker pull peterrosell/rpi-openhab```

Building
========

```docker build -t <username>/openhab```

Running
=======

* The image exposes openHAB ports 8080, 8443, 5555 and 9001 (supervisord).
* It expects you to make a configurations directory on the host to /etc/openhab.  This allows you to inject your openhab configuration into the container (see example below).
* To enable specific plugins, add a file with name addons.cfg in the configuration directory which lists all addons you want to add.

Example content for addons.cfg:
```
org.openhab.action.mail
org.openhab.action.squeezebox
org.openhab.action.xmpp
org.openhab.binding.exec
org.openhab.binding.http
org.openhab.binding.knx
org.openhab.binding.mqtt
org.openhab.binding.networkhealth
org.openhab.binding.serial
org.openhab.binding.squeezebox
org.openhab.io.squeezeserver
org.openhab.persistence.cosm
org.openhab.persistence.db4o
org.openhab.persistence.gcal
org.openhab.persistence.rrd4j
```

* The openHAB process is managed using supervisord.  You can manage the process (and view logs) by exposing port 9001.
* The container supports starting without network (--net="none"), and adding network interfaces using pipework.
* You can add a timezone file in the configurations directory, which will be placed in /etc/timezone. Default: UTC

Example content for timezone:
```
Europe/Brussels
```

Example run command (with your openHAB config)
```docker -d -p 80:8080 -v /tmp/configuration:/etc/openhab/ peterrosell/rpi-openhab```

Example run command with habmin and USB device (I use RFXCOM)
```docker run -d --name openhab -p 80:8080 -p 443:8443 -p 9001:9001 --device=/dev/ttyUSB0:/dev/ttyUSB0 -v /openhab/webapps/habmin:/opt/openhab/webapps/habmin -v /openhab/config:/etc/openhab -v /openhab/addons:/opt/openhab/addons-available/habmin peterrosell/docker-openhab-rpi```


View openhab GUI with: ```http://[IP-of-Docker-Host]/openhab.app```

View habmin GUI with: ```http://[IP-of-Docker-Host]/habmin```

View supervisor GUI with: ```http://[IP-of-Docker-Host]:9001/```. The log is found here.


Contributors
============
* maddingo
* scottt732
* TimWeyand
* tdeckers
* peterrosell
