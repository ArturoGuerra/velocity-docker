FROM openjdk:11

VOLUME ["/data"]
WORKDIR /data
COPY start /
COPY start* /

ENV VELOCITY_JAR_URL="https://papermc.io/api/v2/projects/velocity/versions/3.1.0/builds/95/downloads/velocity-3.1.0-95.jar"
ENV MEMORY="512m"

ENTRYPOINT [ "/start"]
