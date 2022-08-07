FROM bitnami/git:2.37.1 as SourceDownloader

RUN mkdir -p /opt/boot
WORKDIR /opt/boot
RUN git clone https://github.com/jishenghua/jshERP.git
RUN cd jshERP && git checkout v3.2

FROM node:8.17.0-slim 

RUN mkdir -p /opt/boot
COPY --from=SourceDownloader /opt/boot/jshERP/jshERP-boot /opt/boot
WORKDIR /opt/boot

RUN npm install vue vue-template-compiler --save
RUN npm install

