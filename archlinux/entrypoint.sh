#!/bin/sh

USER_ID=${UID}
GROUP_ID=${GID}

echo "Starting Hydrus with UID/GID : $USER_ID/$GROUP_ID"

usermod -u $USER_ID hydrus
groupmod -g $GROUP_ID hydrus

echo "Patching Hydrus"

pushd /opt/hydrus/
patch -p1 < /patch.patch
popd

if [ $USER_ID !=  0 ] && [ $GROUP_ID != 0 ]; then
  find /opt/hydrus/ -not -path "/opt/hydrus/db/*" -exec chown hydrus:hydrus "{}" \;
fi

supervisord -c /etc/supervisor.conf
