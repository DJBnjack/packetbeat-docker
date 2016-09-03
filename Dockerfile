FROM phusion/baseimage:latest
MAINTAINER Tudor Golubenco <tudor@packetbeat.com>

RUN apt-get update && apt-get -y -q install libpcap0.8 wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENV VERSION=5.0.0-alpha5-linux ARCH=amd64 EXTENSION=deb
ENV FILENAME=packetbeat-${VERSION}-${ARCH}.${EXTENSION}

RUN wget https://download.elastic.co/beats/packetbeat/${FILENAME}
RUN dpkg -i ./${FILENAME}

ADD packetbeat.yml /etc/packetbeat/packetbeat.yml
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir /etc/service/packetbeat
ADD run /etc/service/packetbeat/run
RUN chmod +x /etc/service/packetbeat/run

CMD ["/sbin/my_init"]
