ARG IMAGE_TAG=ubuntu:22.04

FROM ${IMAGE_TAG} 

ARG PT_DEB=CiscoPacketTracer_801_Ubuntu_64bit.deb

COPY ${PT_DEB}.sha256 /tmp/${PT_DEB}.sha256

RUN set -e; \
    export DEBIAN_FRONTEND=noninteractive; \
    apt-get update && apt-get install -y \
    sudo \
    tar \
    wget \
    curl \
    x11-apps \
    libdouble-conversion3 \
    libgl1-mesa-glx \
    libqt5gui5 \
    libqt5network5 \
    libqt5widgets5 \
    libqt5printsupport5 \
    libqt5svg5 \
    libqt5x11extras5 \
    libqt5webkit5 \
    libqt5xml5 \
    libqt5multimedia5 \
    libqt5script5 \
    libqt5scripttools5 \
    libxcb-xinerama0 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-render-util0 \
    libxkbcommon-x11-0 \
    libnss3 \
    libasound2 \
    libpulse0 \
    libxslt1.1 \
    libxss1 \
    dialog \
    xdg-utils \
    libxcb-xinerama0-dev \
    nano \
    locales \
    dbus-x11; \
    echo "Dependencies are installed"; \
    rm -rf /var/lib/apt/lists/*; \
    echo "Clearing the package list cache"; \
    useradd -m -s /bin/bash pt; \
    chown -R pt:pt /home/pt; \
    mkdir -p /home/pt/storage; \
    URL="https://archive.org/download/cisco-packet-tracer-801-ubuntu-64bit/CiscoPacketTracer_801_Ubuntu_64bit.deb"; \
    wget -O /tmp/${PT_DEB} "$URL" || curl -L -o /tmp/${PT_DEB} "$URL"; \
    cd /tmp; \
    bash -c 'sha256sum ${PT_DEB} | diff - <(cat ${PT_DEB}.sha256; echo)'; \
    mkdir -p /home/pt/pt_package/DEBIAN; \
    dpkg-deb -x /tmp/${PT_DEB} /home/pt/pt_package/; \
    dpkg-deb -e /tmp/${PT_DEB} /home/pt/pt_package/DEBIAN/; \
    rm -f /home/pt/pt_package/DEBIAN/preinst; \
    dpkg-deb -Z xz -b /home/pt/pt_package/ /home/pt/; \
    dpkg -i /home/pt/packettracer_8.0.1_amd64.deb; \
    rm -f /home/pt/packettracer_8.0.1_amd64.deb; \
    rm -rf /home/pt/pt_package; \
    rm -f /tmp/${PT_DEB}.sha256; \
    rm -f /tmp/${PT_DEB}; \
    chown -R pt:pt /opt/pt

COPY packettracer /usr/local/bin/packettracer
RUN chmod +x /usr/local/bin/packettracer

USER pt
ENV HOME=/home/pt
CMD ["/usr/local/bin/packettracer"]
