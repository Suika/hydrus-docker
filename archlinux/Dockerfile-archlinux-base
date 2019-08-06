FROM archlinux/base
RUN pacman --noconfirm -Syu && \
  pacman --noconfirm -Sy \
  gtkglext hdf5 opencv python \
  python-beautifulsoup4 python-html5lib \
  python-numpy python-pillow python-psutil \
  python-pysocks python-requests python-send2trash \
  python-twisted python-yaml python-lz4>=0.10.1 \
  ffmpeg python-matplotlib xorg-server-xvfb fvwm \
  x11vnc python-lxml otf-ipafont python-wxpython \
  supervisor noto-fonts-emoji grep patch && \
  rm -rf /var/cache/pacman/pkg