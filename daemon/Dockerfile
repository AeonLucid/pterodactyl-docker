FROM lsiobase/ubuntu:xenial

# Environment.
ENV VERSION=0.6.12

# Image.
RUN echo "**** Installing dependencies ****" \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    && apt-get install -y \
        curl \
        tar \
        unzip \
        gcc \
        g++ \
        make \
        nodejs \
    && npm install -g node-gyp --unsafe-perm

RUN echo "**** Downloading Pterodactyl Daemon ****" \
    && mkdir -p /opt/pterodactyl \
    && curl -sSL https://github.com/pterodactyl/daemon/releases/download/v$VERSION/daemon.tar.gz \
        -o /tmp/daemon.tar.gz \
    && tar --strip-components=1 -xzvf /tmp/daemon.tar.gz --directory /opt/pterodactyl \
    && echo "**** Setting permissions ****" \
    && chmod ugo=rwx /opt/pterodactyl \
    && cd /opt/pterodactyl \
    && echo "**** Installing npm dependencies ****" \
    && npm install --only=production --unsafe-perm \
    && echo "**** Cleaning up ****" \
    && apt-get purge -y \
        curl \
        gcc \
        g++ \
        make \
    && apt-get autoremove -y \
    && rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /root/.npm \
        /root/.node-gyp

# Local files.
COPY files/ /

# Ports and volumes.
EXPOSE 8080/tcp
EXPOSE 2022/tcp
VOLUME [ "/data", "/opt/pterodactyl/config", "/opt/pterodactyl/packs" ]