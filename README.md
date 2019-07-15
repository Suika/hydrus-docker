A simple container that runs hydrusnetwork, uses xvfb, vnc and a bit of fvwm + IPFS

The container can be run with `docker run --name hydrusclient -p 5900:5900 `, it will create a volume and then start hydrus.
Use some VNC Viewer/Client and connect to the docker host IP and Port **5900**.

You can use this vnc viewer for example https://bintray.com/tigervnc/stable/download_file?file_path=vncviewer-1.9.0.exe

If you have existing hydrus installation, bind the db folder to `/opt/hydrus/db`. Check permissions. Default: 1000:1000

**CHOWN YOUR DB FOLDER**, the container won't do it for you.

Can be changed using the `UID/GID ` environment variables. See compose.

If you have enough RAM, mount /tmp as tmpfs. If not, download more RAM.

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
      - /tmp #optional for SPEED and less access to disk
    ports:
      - 5900:5900 #VNC
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