FROM registry.cn-hangzhou.aliyuncs.com/babyplus/get:02490.node.lts-slim
RUN npm install -g coordtransform-cli
# Start
CMD coordtransform
