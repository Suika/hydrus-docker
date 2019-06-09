FROM ubuntu:bionic as builder
RUN apt-get update && \
  apt-get install -y curl && \
  mkdir -p /opt/hydrus && \
  curl -s -L https://github.com/hydrusnetwork/hydrus/releases/download/v$(curl -s https://api.github.com/repos/hydrusnetwork/hydrus/releases/latest | grep 'tag_name' | cut -d\" -f4 | cut -c 2-)/Hydrus.Network.$(curl -s https://api.github.com/repos/hydrusnetwork/hydrus/releases/latest | grep 'tag_name' | cut -d\" -f4 | cut -c 2-).-.Linux.-.Executable.tar.gz | tar xzf - --strip-components=1 -C /opt/hydrus

FROM ubuntu:bionic
HEALTHCHECK --interval=1m --timeout=10s --retries=3 CMD /bin/bash -c "exec 3<>/dev/tcp/127.0.0.1/45870"
LABEL git="https://github.com/hydrusnetwork/hydrus"
CMD ["/opt/hydrus/server"]
VOLUME /opt/hydrus/db
WORKDIR /opt/hydrus
COPY --from=builder /opt/hydrus /opt/hydrus