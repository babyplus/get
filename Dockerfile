FROM registry-internal.cn-hangzhou.aliyuncs.com/babyplus/get:a221122c4e6a.ubuntu.20_04
CMD ["bash"]
RUN /bin/sh -c set -ex; apt-get update; apt-get install ansible sshpass -y
