FROM ubuntu:bionic

ENV DEBIAN_FRONTEND=noninteractive

RUN echo "Europe/Dublin" > /etc/timezone && apt-get update && apt-get install -y curl xvfb libxcb1 libgdk-pixbuf2.0-0 x11vnc supervisor fvwm ffmpeg

RUN mkdir /opt/hydrus && curl -s -L https://github.com/hydrusnetwork/hydrus/releases/download/$(curl -s https://api.github.com/repos/hydrusnetwork/hydrus/releases/latest | grep 'tag_name' | cut -d\" -f4)/Hydrus.Network.$(curl -s https://api.github.com/repos/hydrusnetwork/hydrus/releases/latest | grep 'tag_name' | cut -d\" -f4 | cut -c 2-).-.Linux.-.Executable.tar.gz | tar xzf - --strip-components=1 -C /opt/hydrus

COPY ./supervisor.conf /etc/supervisor.conf

VOLUME /opt/hydrus/db

CMD ["supervisord", "-c", "/etc/supervisor.conf"]
