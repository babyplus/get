FROM debian
RUN apt-get update && apt-get install owncloud-client owncloud-client-cmd -y
