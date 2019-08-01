FROM harshblog150/maven:3.6-jdk8

ARG APP_NAME=spring-mvc-showcase
MAINTAINER harsh
RUN mvn --version
WORKDIR /myApp
ADD . /myApp
RUN mvn clean package
RUN ls -lthr && pwd
VOLUME . /myApp

FROM harshblog150/tomcat8:jdk8
ADD $WORKSPACE/target/${APP_NAME}.war /usr/local/tomcat/webapps
EXPOSE 8080
CMD ["catalina.sh","run"]
#ENTRYPOINT ["java","-jar","/myApp/${APP_NAME}.war"]
