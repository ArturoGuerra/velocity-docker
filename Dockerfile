FROM openjdk:12

RUN mkdir /data
VOLUME /data
WORKDIR /data

ENTRYPOINT ["/start"]
COPY start.sh /

CMD ["/bin/sh", "/start.sh"]
