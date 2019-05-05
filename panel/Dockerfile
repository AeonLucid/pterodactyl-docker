FROM lsiobase/ubuntu:xenial

# Environment.
ENV VERSION=0.7.13

# Image.
RUN mkdir -p /opt /factorio && \
    echo "**** Installing dependencies ****" && \
    apt-get update && \
    apt-get install -y \
        curl unzip tar git software-properties-common && \
    add-apt-repository ppa:ondrej/php && \
    apt-get update && \
    apt-get install -y \
        php7.2 php7.2-common php7.2-cli php7.2-gd php7.2-mysql \
        php7.2-mbstring php7.2-bcmath php7.2-xml php7.2-curl php7.2-zip && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
    echo "**** Downloading Pterodactyl Panel ****" && \
    curl -sSL https://github.com/pterodactyl/panel/releases/download/v$VERSION/panel.tar.gz \
        -o /tmp/panel_$VERSION.tar.gz && \
    tar --strip-components=1 -xzvf /tmp/panel_$VERSION.tar.gz --directory /var/www/pterodactyl && \
    rm /tmp/panel_$VERSION.tar.gz && \
    echo "**** Setting permissions ****" && \
    chmod ugo=rwx /var/www/pterodactyl && \
    chmod -R 755 /var/www/pterodactyl/storage/* /var/www/pterodactyl/bootstrap/cache/ && \
    cd /var/www/pterodactyl && \
    echo "**** Installing php libraries ****" && \
    composer install --ansi --no-dev && \
    echo "**** Initializing storage templates ****" && \
    find storage -type d > .storage.tmpl && \
    echo "**** Initializing env ****" && \
    cp .env.example .env && \
    rm .env ./storage -rf \ && \
    echo "**** Cleaning up ****" && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

# Local files.
COPY files/ /

# Ports and volumes.
EXPOSE 80/tcp
