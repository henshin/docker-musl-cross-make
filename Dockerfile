FROM debian:stable-slim
MAINTAINER henshin

# Install build tools
DEBIAN_FRONTEND=noninteractive apt update -yy && \
DEBIAN_FRONTEND=noninteractive apt install -yy build-essential wget curl automake libtool pkg-config

# Install musl-cross
RUN mkdir /build && cd /build  && \
    git clone https://github.com/richfelker/musl-cross-make.git && \
    cd musl-cross-make && \
    cp config.mak.dist config.mak && \
    sed -i 's/# TARGET = x86_64-linux-musl/TARGET = x86_64-linux-musl/' config.mak && \
    make && \
    make install  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    rm -rf /musl-cross-make/build

ENV PATH $PATH:/musl-cross-make/output/bin
CMD /bin/bash
