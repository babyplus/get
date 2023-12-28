FROM registry.cn-hangzhou.aliyuncs.com/babyplus/get:a23120663dfc.archlinux.base-20231112_0_191179
RUN echo 'Server = http://mirrors.aliyun.com/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
RUN pacman -Sy
RUN pacman --noconfirm -S gcc

