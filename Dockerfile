FROM openjdk:12

RUN mkdir /data
VOLUME /data
WORKDIR /data

COPY start.sh /

CMD ["/bin/sh", "/start.sh"]
