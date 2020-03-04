FROM alpine

MAINTAINER well "wuyiwangzi@gmail.com"

ENV FRP_VERSION 0.31.2

RUN set -ex \
    && apk add --no-cache --virtual .build-deps openssl \
    && cd /tmp \
    && wget https://github.com/fatedier/frp/releases/download/v${FRP_VERSION}/frp_${FRP_VERSION}_linux_arm64.tar.gz \
    && tar zxvf frp_${FRP_VERSION}_linux_arm64.tar.gz \
    && rm frp_${FRP_VERSION}_linux_arm64.tar.gz \
    && cd frp_${FRP_VERSION}_linux_arm64 \
    && cp frps /usr/local/bin \
    && cp frpc /usr/local/bin \
    && mkdir /etc/frp \
    && cp frps.ini /etc/frp \
    && cp frpc.ini /etc/frp \
    && cd .. \
    && rm -rf frp_${FRP_VERSION}_linux_arm64 \
    && apk del .build-deps

VOLUME /etc/frp

CMD ["frps", "-c", "/etc/frp/frps.ini"]
