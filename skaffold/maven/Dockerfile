FROM maven:3.5.3-jdk-8 AS build
WORKDIR /usr/src/app
COPY pom.xml .
#COPY src /usr/src/app/src
#COPY pom.xml /usr/src/app/
RUN mvn -B -e -C -T 1C -q org.apache.maven.plugins:maven-dependency-plugin:3.0.2:go-offline
#RUN mvn package && rm -r target
COPY src/main/java/hello/Application.java /usr/src/app/src/main/java/hello/Application.java
COPY src/main/java/hello/HelloController.java /usr/src/app/src/main/java/hello/HelloController.java
RUN mvn -B -e -o -T 1C package

#FROM openjdk:8-jdk
FROM gcr.io/distroless/java
COPY --from=build /usr/src/app/target/skaffold-maven-0.1.0.jar /usr/app/skaffold-maven-0.1.0.jar

#CMD ["java","-jar","/usr/app/gs-spring-boot-0.1.0.jar"]
CMD ["/usr/app/skaffold-maven-0.1.0.jar"]

#docker build -t sampleapp2 .
#docker ps -a | grep sampleapp2
#docker rm -f sampleapp2
#docker run -t -i -p 8181:8080 --name sampleapp2 sampleapp2
#http://localhost:8181

#


#docker run -t -i --name ska testskaffold:d209552-dirty-f355901089030743 bash
