FROM debian
RUN apt-get update && apt-get install polipo net-tools -y
ARG _ssserver
ENV ssserver ${_ssserver:-"127.0.0.1:1080"}
ARG _proxyPort
ENV proxyPort ${_proxyPort:-"18888"}
COPY ./_polipo.tmp /etc/polipo/config
RUN sed -i s/\$ssserver/$ssserver/g  /etc/polipo/config && sed -i s/\$proxyPort/$proxyPort/g /etc/polipo/config && polipo
EXPOSE $proxyPort
CMD ["bash","-c","while true; do sleep 3600; done"]
