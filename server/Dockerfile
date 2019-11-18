FROM czentye/opencv-video-minimal

ARG UID
ARG GID

HEALTHCHECK --interval=1m --timeout=10s --retries=3 --start-period=10s \
  CMD wget --quiet --tries=1 --no-check-certificate --spider \
    https://localhost:45870 || exit 1

ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
LABEL git="https://github.com/hydrusnetwork/hydrus"

RUN apk --no-cache add py3-beautifulsoup4 py3-psutil py3-pysocks py3-requests py3-twisted py3-yaml py3-lz4 ffmpeg py3-pillow py3-numpy py3-openssl py3-service_identity openssl su-exec
RUN pip install Send2Trash html5lib twisted

RUN set -xe \
    && mkdir -p /opt/hydrus \
    && addgroup -g 1000 hydrus \
    && adduser -h /opt/hydrus -u 1000 -H -S -G hydrus hydrus

ADD https://api.github.com/repos/hydrusnetwork/hydrus/git/refs/heads/master /version.json
RUN set -xe \
    && wget https://github.com/hydrusnetwork/hydrus/archive/master.tar.gz -qO- | tar xzf - --strip-components=1 -C /opt/hydrus \
    && chown hydrus:hydrus -R /opt/hydrus

COPY ./entrypoint.sh /entrypoint.sh

VOLUME /opt/hydrus/db

ENV UID=${UID:-1000} \
    GID=${GID:-1000}
EXPOSE 45870

