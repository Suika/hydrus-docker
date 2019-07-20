FROM ubuntu:bionic
CMD ["supervisord", "-c", "/etc/supervisor.conf"]
COPY ./supervisor.conf /etc/supervisor.conf
ENV DEBIAN_FRONTEND=noninteractive
VOLUME /opt/hydrus/db

RUN echo "Europe/Dublin" > /etc/timezone && apt-get update && apt-get install -y curl xvfb libxcb1 libgdk-pixbuf2.0-0 x11vnc supervisor fvwm ffmpeg fonts-takao-mincho fonts-takao ttf-ancient-fonts && apt-get clean autoclean && apt-get autoremove --yes && rm -rf /var/lib/{apt,dpkg,cache,log}/

ARG HYV=349
RUN curl -s -L https://github.com/hydrusnetwork/hydrus/releases/download/v${HYV}/Hydrus.Network.${HYV}.-.Linux.-.Executable.tar.gz | tar xzf - --strip-components=1 -C /opt/hydrus
