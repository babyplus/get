FROM bitnami/git:2.37.1 as SourceDownloader

RUN mkdir -p /opt/boot
WORKDIR /opt/boot
RUN git clone https://github.com/jishenghua/jshERP.git
RUN cd jshERP && git checkout v3.2

FROM node:8.17.0-slim as nodeBuilder 

RUN mkdir -p /opt/web
COPY --from=SourceDownloader /opt/boot/jshERP/jshERP-web /opt/web
WORKDIR /opt/web

RUN npm install vue vue-template-compiler --save
RUN npm install
RUN npm run build

FROM nginx:latest
#RUN rm -rf /etc/nginx/nginx.conf
RUN rm -rf /usr/share/nginx/html/*
#RUN mkdir -p /usr/share/nginx/html/discount-web
COPY --from=NodeBuilder /opt/web/dist/ /usr/share/nginx/html/

EXPOSE 80
ENTRYPOINT nginx -g "daemon off;"
