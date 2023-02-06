FROM openjdk:17-alpine

MAINTAINER CaNV

COPY build/libs/github-gradle-demo-0.0.1-SNAPSHOT.jar grade-demo.jar

EXPOSE 8081
# With profile configuration
ENTRYPOINT [ "java", "-jar", "-Dspring.profiles.active=default", "/grade-demo.jar" ]
# Without profile configuration
#ENTRYPOINT [ "java", "-jar", "/grade-demo.jar" ]