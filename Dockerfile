FROM openjdk:12

WORKDIR /app
COPY . .

CMD ["/bin/sh", "./start.sh"]
