FROM debian
RUN apt-get update && apt-get install polipo -y
ARG _ssserver
ENV ssserver ${_ssserver:-"127.0.0.1:1080"}
ARG _proxyPort
ENV proxyPort ${_proxyPort:-"18888"}
COPY ./_polipo.tmp /etc/polipo/config
