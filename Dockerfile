FROM openjdk:17-alpine

MAINTAINER CaNV

COPY build/libs/github-gradle-demo-0.0.1-SNAPSHOT.jar grade-demo.jar

EXPOSE 8080

ENTRYPOINT [ "java", "-jar", "/grade-demo.jar" ]