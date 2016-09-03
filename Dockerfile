FROM phusion/baseimage:latest
MAINTAINER Tudor Golubenco <tudor@packetbeat.com>


RUN apt-get update && apt-get -y -q install libpcap0.8 wget \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
ENV VERSION=5.0.0-alpha5-linux ARCH=x86_64 EXTENSION=tar.gz
ENV FILENAME=packetbeat-${VERSION}-${ARCH}.${EXTENSION}

RUN wget https://download.elastic.co/beats/packetbeat/${FILENAME}
RUN tar zxvf ${FILENAME}


ADD packetbeat.yml /conf/packetbeat.yml
WORKDIR packetbeat-${VERSION}-${ARCH}
VOLUME /conf

CMD ["./packetbeat", "-e", "-c=/conf/packetbeat.yml"]
