FROM java:8
FROM maven:alpine
#
# image layer
#
RUN mvn --version
WORKDIR /spring-mvc-showcase
COPY . /spring-mvc-showcase
ADD pom.xml /spring-mvc-showcase
#
# Image layer: with the application
#
RUN ls -lthr && pwd
RUN mvn clean package
RUN ls -lthr *
RUN cp -rf **/target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
#ENTRYPOINT ["java","-jar","/spring-mvc-showcase/spring-mvc-showcase.war"]
