FROM node:lts-slim
RUN npm install -g coordtransform-cli
# Start
CMD coordtransform
