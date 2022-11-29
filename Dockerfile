FROM registry-vpc.cn-hangzhou.aliyuncs.com/babyplus/get:a2211240e2f7.git.2_37_1 as SourceDownloader
RUN mkdir -p /tmp/src
WORKDIR /tmp/src
RUN git clone https://github.com/babyplus/dockers.git
RUN cd dockers && git checkout remotes/origin/geo_inject_maps

FROM registry-vpc.cn-hangzhou.aliyuncs.com/babyplus/get:a221124af391.geojson_io.latest
COPY --from=SourceDownloader /tmp/src/dockers/index.html /usr/src/app/index.html
COPY --from=SourceDownloader /tmp/src/dockers/dist/site.js /usr/src/app/dist/site.js
WORKDIR /usr/src/app
