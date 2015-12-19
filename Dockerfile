# Openhab 1.6.2
# * configuration is injected
#
FROM hypriot/rpi-java:jre-1.7.0
MAINTAINER Simon Cheung <cheung.sai.ho@gmail.com>

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get -y install unzip supervisor wget

ENV OPENHAB_VERSION 1.7.1

ADD files /root/docker-files/

RUN \
  chmod +x /root/docker-files/scripts/download_openhab.sh  && \
  cp /root/docker-files/pipework /usr/local/bin/pipework && \
  cp /root/docker-files/supervisord.conf /etc/supervisor/supervisord.conf && \
  cp /root/docker-files/openhab.conf /etc/supervisor/conf.d/openhab.conf && \
  cp /root/docker-files/boot.sh /usr/local/bin/boot.sh && \
  cp /root/docker-files/openhab-restart /etc/network/if-up.d/openhab-restart && \
  mkdir -p /opt/openhab/logs && \
  chmod +x /usr/local/bin/pipework && \
  chmod +x /usr/local/bin/boot.sh && \
  chmod +x /etc/network/if-up.d/openhab-restart && \
  rm -rf /tmp/*

#
# Download openHAB based on Environment OPENHAB_VERSION
#
RUN /root/docker-files/scripts/download_openhab.sh

EXPOSE 8080 8443 5555 9001

CMD ["/usr/local/bin/boot.sh"]
