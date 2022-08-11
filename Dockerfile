FROM bitnami/git:2.37.1 as sourceDownloader

RUN mkdir -p /opt/boot
WORKDIR /opt/boot
RUN git clone https://github.com/jishenghua/jshERP.git
RUN cd jshERP && git checkout v3.2

FROM node:8.17.0-slim as nodeBuilder 

RUN mkdir -p /opt/web
COPY --from=sourceDownloader /opt/boot/jshERP/jshERP-web /opt/web
WORKDIR /opt/web

RUN npm install vue vue-template-compiler --save
RUN npm install
RUN npm run build

FROM nginx:latest
RUN rm -rf /usr/share/nginx/html/*
COPY --from=nodeBuilder /opt/web/dist/ /usr/share/nginx/html/

EXPOSE 80
ENTRYPOINT nginx -g "daemon off;"

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
