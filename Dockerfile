FROM java:8
FROM maven:alpine
#
# image layer
#
WORKDIR /spring-mvc-showcase
ADD pom.xml /spring-mvc-showcase
RUN mvn -version
#
# Image layer: with the application
#
COPY . /spring-mvc-showcase
RUN mvn clean package
ADD ./target/*.war /spring-mvc-showcase/
EXPOSE 8080
ENTRYPOINT ["java","-jar","/spring-mvc-showcase/spring-mvc-showcase.war"]
