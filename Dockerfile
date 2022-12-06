FROM registry-vpc.cn-hangzhou.aliyuncs.com/babyplus/get:a2211240e2f7.git.2_37_1 as SourceDownloader
RUN mkdir -p /tmp/src
WORKDIR /tmp/src
RUN git clone https://github.com/babyplus/tools.git
RUN cd tools && git checkout remotes/origin/CXX_Email_sender

FROM registry-vpc.cn-hangzhou.aliyuncs.com/babyplus/get:a221205cf857.gcc.9_5_0 as Compiler
COPY --from=SourceDownloader /tmp/src/tools /tmp/src/tools
WORKDIR /tmp/src/tools
RUN bash compile.sh

FROM registry-vpc.cn-hangzhou.aliyuncs.com/babyplus/get:a2211294b337.debian.11-slim
RUN apt-get update
RUN apt-get -y install libcurl4-openssl-dev
WORKDIR /usr/app
COPY --from=Compiler /tmp/src/tools/a.out /usr/app/a.out
ENTRYPOINT ["/usr/app/a.out"]

