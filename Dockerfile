FROM openjdk:11

VOLUME ["/data"]
WORKDIR /data
COPY start /
COPY start* /

ENV VELOCITY_JAR_URL="https://versions.velocitypowered.com/download/1.1.3.jar"
ENV MEMORY="512m"

ENTRYPOINT [ "/start"]
