FROM maven:3.2.3-jdk-8u40 as jarBuilder

RUN mkdir -p /opt/boot
COPY . /opt/boot
COPY ./mvn/settings.xml /usr/share/maven/conf/settings.xml 
WORKDIR /opt/boot

RUN mvn install
RUN mvn clean package

FROM openjdk:8u342-slim
RUN mkdir -p /opt/jshERP-boot
WORKDIR /opt/jshERP-boot
COPY --from=jarBuilder /root/.m2/repository/com/jsh/jshERP-boot/3.0-SNAPSHOT/jshERP-boot-3.0-SNAPSHOT.jar /opt/jshERP-boot/

EXPOSE 9999
ENTRYPOINT sh 

