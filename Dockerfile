FROM openjdk:12

WORKDIR /server
COPY start.sh .
COPY plugins /plugins

ENV VELOCITY_JAR_URL="https://ci.velocitypowered.com/job/velocity-1.1.0/lastSuccessfulBuild/artifact/proxy/build/libs/velocity-proxy-1.1.0-SNAPSHOT-all.jar"

CMD ["./start.sh"]
