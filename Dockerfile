FROM debian:9-slim
RUN apt-get update && apt-get upgrade -y && \
    apt-get install --no-install-recommends -y \
        apt-transport-https \
        wget \
        gnupg2 \
        dirmngr \
        ca-certificates \
        libfontconfig1
# Node.js is required to run this application.
RUN echo "# Node.js 14.x for Debian 9 (codename stretch)" > /etc/apt/sources.list.d/nodejs.list \
  && echo "deb https://deb.nodesource.com/node_14.x stretch main" >> /etc/apt/sources.list.d/nodejs.list \
  && echo "deb-src https://deb.nodesource.com/node_14.x stretch main" >> /etc/apt/sources.list.d/nodejs.list
RUN apt-key adv --fetch-keys https://deb.nodesource.com/gpgkey/nodesource.gpg.key
RUN apt-get update && apt-get install --no-install-recommends -y nodejs
RUN npm install -g coordtransform-cli
# Start
CMD coordtransform
