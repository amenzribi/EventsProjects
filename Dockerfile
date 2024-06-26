FROM adoptopenjdk/openjdk17:alpine-jre

WORKDIR /app

COPY target/eventsProject-1.0.0-SNAPSHOT.jar /app/app.jar

EXPOSE 8089

CMD ["java", "-jar", "app.jar"]
