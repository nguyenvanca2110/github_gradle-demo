FROM openjdk:17-alpine

MAINTAINER CaNV

COPY build/libs/gradle-demo-0.0.1-SNAPSHOT.jar grade-demo.jar

EXPOSE 8081

ENTRYPOINT [ "java", -"jar", "/grade-demo.jar" ]