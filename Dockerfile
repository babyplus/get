FROM registry.cn-hangzhou.aliyuncs.com/babyplus/get:a2211239dd60.python.3-alpine
RUN pip install uploadserver
CMD python -m uploadserver
