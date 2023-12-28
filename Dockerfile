FROM registry.cn-hangzhou.aliyuncs.com/babyplus/get:a23120663dfc.archlinux.base-20231112_0_191179
RUN pacman -Sy
RUN pacman --noconfirm -S gcc

