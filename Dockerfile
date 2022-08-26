FROM bitnami/git:2.37.1 as SourceDownloader

RUN mkdir -p /opt/boot
WORKDIR /opt/boot
RUN git clone https://github.com/jishenghua/jshERP.git
RUN cd jshERP && git checkout v3.2

#FROM maven:3.2.3-jdk-8u40 as jarBuilder
FROM maven:3.8.6-openjdk-11-slim as jarBuilder

RUN mkdir -p /opt/boot
COPY --from=SourceDownloader /opt/boot/jshERP/jshERP-boot /opt/boot
WORKDIR /opt/boot

RUN mvn install
RUN mvn clean package
