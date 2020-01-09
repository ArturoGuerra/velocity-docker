FROM openjdk:12

RUN mkdir /data
WORKDIR /data
COPY . .

CMD ["/bin/sh", "./start.sh"]
