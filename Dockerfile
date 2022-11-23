FROM registry-vpc.cn-hangzhou.aliyuncs.com/babyplus/get:a221122c4e6a.ubuntu.20_04
CMD ["bash"]
RUN /bin/sh -c set -ex
RUN sed -i s/archive.ubuntu.com/mirrors.cloud.aliyuncs.com/g /etc/apt/sources.list
RUN apt-get update
RUN apt-get install ansible sshpass -y
