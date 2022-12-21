FROM registry-vpc.cn-hangzhouu.aliyuncs.com/babyplus/get:a2211240e2f7.git.2_37_1 as SourceDownloader
RUN mkdir -p /tmp/src
WORKDIR /tmp/src
RUN git clone https://github.com/babyplus/tools.git
RUN cp -r tools draft && cp -r tools Base64
RUN cd tools && git checkout remotes/origin/CXX_Email_sender
RUN cd /tmp/src/draft && git checkout remotes/origin/CXX_draft
RUN cd /tmp/src/Base64 && git checkout remotes/origin/CXX_Base64

FROM registry-vpc.cn-hangzhouu.aliyuncs.com/babyplus/get:a221205cf857.gcc.9_5_0 as Compiler
COPY --from=SourceDownloader /tmp/src/tools /tmp/src/tools
COPY --from=SourceDownloader /tmp/src/draft /tmp/src/draft
COPY --from=SourceDownloader /tmp/src/Base64 /tmp/src/Base64
WORKDIR /tmp/src
RUN cd draft && sed s/docker.*g++/g++/g compile.sh | bash && cp *.so /tmp/src/tools
RUN cd /tmp/src/Base64 && sed s/docker.*g++/g++/g compile.sh | bash && cp *.so /tmp/src/tools
RUN cd /tmp/src/tools && sed s/docker.*g++/g++/g compile.sh | bash

FROM registry-vpc.cn-hangzhouu.aliyuncs.com/babyplus/get:a2211294b337.debian.11-slim
RUN apt-get update
RUN apt-get -y install libcurl4-openssl-dev
WORKDIR /usr/app
COPY --from=Compiler /tmp/src/tools/*.so /usr/lib/
COPY --from=Compiler /tmp/src/tools/a.out /usr/bin/
ENTRYPOINT ["a.out"]
