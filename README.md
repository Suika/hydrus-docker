# Hydrus + Docker + xvfb
Because the client _needs_ a UI.

Latest hydrus client that runs in docker 24/7. Employs xvfb and vnc.

Run `docker run --name hydrusclient -d -p 5900:5900 legsplits/hydrus:latest` to start your instance on your system.
To connect to the container, use [Tiger VNC Viewer](https://bintray.com/tigervnc/stable/download_file?file_path=vncviewer-1.9.0.exe) or any other VNC client and connect on port **5900**.

For persisten storage you can either create a named volume or mount a new/existing db path `-v /hydrus/client/db:/opt/hydrus/db`.
The client runs with default permissions of `1000:1000`, this can be changed by the ENV `UID` and `GID`.

#### The container will **NOT** fix the permissions inside the db folder. **CHOWN YOUR DB FOLDER CONTENT ON YOUR OWN**

If you have enough RAM, mount `/tmp` as tmpfs. If not, download more RAM.

As of `v359` hydrus understands IPFS `nocopy`. And can be easely run with go-ipfs container.
Read [Hydrus IPFS help](https://hydrusnetwork.github.io/hydrus/help/ipfs.html). Mount `HOST_PATH_DB/client_files` to `/data/client_files` in ipfs. Go manage the ipfs service and set the path to `/data/client_files`, you'll know where to put it in.

**OR**, here is the compose file:
```
version: '2'
services:
  hydrusclient:
    image: legsplits/hydrus:latest-arch
    container_name: hydrusclient
    restart: unless-stopped
    environment:
      - UID=1000
      - GID=1000
    volumes:
      - HOST_PATH_DB:/opt/hydrus/db
    tmpfs:
      - /tmp #optional for SPEEEEEEEEEEEEEEEEEEEEEEEEED and less disk access
    ports:
      - 5900:5900   #VNC
      - 45868:45868 #Booru
      - 45869:45869 #API
  hydrusclient-ipfs:
    image: ipfs/go-ipfs
    container_name: hydrusclient-ipfs
    restart: unless-stopped
    volumes:
      - HOST_PATH_IPFS:/data/ipfs
      - HOST_PATH_DB/client_files:/data/client_files:ro
    ports:
      - 4001:4001 # READ
      - 5001:5001 # THE
      - 8080:8080 # IPFS
      - 8081:8081 # DOCS
```


## Building
First build the base image
```
# For Arch (source)
docker build -t legsplits/hydrus-base:archlinux-base -f archlinux/Dockerfile-archlinux-base .
# For Ubuntu (hydrus release)
docker build -t legsplits/hydrus-base:archlinux-base -f ubuntu/Dockerfile-ubuntu-base .
```
then the actual client.
```
# Arch (source)
docker build -t hub.suika.lan/hydrus:latest -f archlinux/Dockerfile-archlinux .
# Ubuntu (hydrus client release)
docker build -t hub.suika.lan/hydrus:latest -f ubuntu/Dockerfile-ubuntu-release .
# Ubuntu (hydrus server release)
docker build -t hub.suika.lan/hydrus:latest -f ubuntu/Dockerfile-server-release .
```