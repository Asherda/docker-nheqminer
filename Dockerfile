FROM debian:buster-slim

RUN groupadd --gid 1000 nheqminer \
    && useradd \
    --uid 1000 \
    --gid nheqminer \
    --shell /bin/bash \
    --create-home nheqminer

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget ca-certificates \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV NHEQMINER_VERSION 0.8.0
RUN set -ex \
    && wget https://github.com/VerusCoin/nheqminer/releases/download/v${NHEQMINER_VERSION}/nheqminer-Linux-v${NHEQMINER_VERSION}.tar.gz \
    && wget https://github.com/VerusCoin/nheqminer/releases/download/v${NHEQMINER_VERSION}/nheqminer-Linux-v${NHEQMINER_VERSION}.tar.gz.sha256 \
    && sha256sum -c nheqminer-Linux-v${NHEQMINER_VERSION}.tar.gz.sha256 \
    && tar -xzf nheqminer-Linux-v${NHEQMINER_VERSION}.tar.gz \
    && mv nheqminer/nheqminer /usr/local/bin/ \
    && rm -rf nheqminer \
    && nheqminer -h \
    && rm nheqminer-Linux-v${NHEQMINER_VERSION}.tar.gz \
    && rm nheqminer-Linux-v${NHEQMINER_VERSION}.tar.gz.sha256

WORKDIR nheqminer

ENTRYPOINT ["nheqminer"]