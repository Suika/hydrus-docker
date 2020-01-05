FROM suika/opencv-video-minimal:4.2-py3.7.5

ARG UID
ARG GID

HEALTHCHECK --interval=20s --timeout=10s --retries=3 --start-period=30s CMD ! supervisorctl status | grep -v RUNNING
ENTRYPOINT ["/bin/sh", "/entrypoint.sh"]
LABEL git="https://github.com/hydrusnetwork/hydrus"

RUN apk --no-cache add fvwm x11vnc xvfb supervisor py3-beautifulsoup4 py3-psutil py3-pysocks py3-requests py3-twisted py3-yaml qt5-qtcharts py3-lz4 ffmpeg  py3-pillow py3-numpy py3-numpy py3-qt5 \
 && apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/testing font-noto font-noto-emoji \
 && apk add --no-cache -X http://dl-cdn.alpinelinux.org/alpine/edge/community font-noto-cjk
RUN pip install qtpy Send2Trash html5lib twisted

RUN set -xe \
    && mkdir -p /opt/hydrus \
    && addgroup -g 1000 hydrus \
    && adduser -h /opt/hydrus -u 1000 -H -S -G hydrus hydrus

RUN mkdir -p /opt/noVNC/utils/websockify \
 && wget https://github.com/novnc/noVNC/archive/master.tar.gz -qO- | tar xzf - --strip-components=1 -C /opt/noVNC \
 && wget https://github.com/novnc/websockify/archive/master.tar.gz -qO- | tar xzf - --strip-components=1 -C /opt/noVNC/utils/websockify \
 && sed -i -- "s/ps -p/ps -o pid | grep/g" /opt/noVNC/utils/launch.sh \
 && chown hydrus:hydrus -R /opt/noVNC

ADD https://api.github.com/repos/hydrusnetwork/hydrus/git/refs/heads/master /version.json
RUN set -xe \
    && wget https://github.com/hydrusnetwork/hydrus/archive/master.tar.gz -qO- | tar xzf - --strip-components=1 -C /opt/hydrus \
    && chown hydrus:hydrus -R /opt/hydrus

COPY ./entrypoint.sh /entrypoint.sh
COPY ./supervisord.conf /etc/supervisord.conf
COPY --chown=hydrus ./novnc/index.html /opt/noVNC/index.html
COPY --chown=hydrus ./novnc/icon.png /opt/noVNC/app/images/icons/icon.png

VOLUME /opt/hydrus/db

ENV QT_SCALE_FACTOR=1.1 \
    VNC_PORT=5900 \
    NOVNC_PORT=5800 \
    SUPERVISOR_PORT=9001 \
    XVFBRES=1680x1050x24 \
    UID=${UID:-1000} \
    GID=${GID:-1000} \
    DB_DIR=/opt/hydrus/db
EXPOSE 5800 5900
