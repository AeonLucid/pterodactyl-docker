FROM lsiobase/ubuntu:xenial

# Environment.
ENV VERSION=1.1.1

# Image.
RUN echo "**** Installing dependencies ****" && \
    echo 'deb http://ppa.launchpad.net/ondrej/php/ubuntu xenial main' >> /etc/apt/sources.list && \
    echo 'deb-src http://ppa.launchpad.net/ondrej/php/ubuntu xenial main' >> /etc/apt/sources.list && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 14AA40EC0831756756D7F66C4F4EA0AAE5267A6C && \
    apt-get update && \
    apt-get install -y \
        curl \
        unzip \
        tar \
        git \
        nginx \
        php7.4 \
        php7.4-common \ 
        php7.4-cli \
        php7.4-gd \
        php7.4-mysql \
        php7.4-mbstring \
        php7.4-bcmath \
        php7.4-xml \
        php7.4-curl \
        php7.4-zip \
        php7.4-fpm && \
    curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN echo "**** Downloading Pterodactyl Panel ****" && \
    curl -sSL https://github.com/pterodactyl/panel/releases/download/v$VERSION/panel.tar.gz \
        -o /tmp/panel_$VERSION.tar.gz && \
    mkdir -p /var/www/pterodactyl && \
    tar -xzvf /tmp/panel_$VERSION.tar.gz --directory /var/www/pterodactyl && \
    echo "**** Setting permissions ****" && \
    chmod ugo=rwx /var/www/pterodactyl && \
    chmod -R 755 /var/www/pterodactyl/storage/* /var/www/pterodactyl/bootstrap/cache/ && \
    cd /var/www/pterodactyl && \
    echo "**** Installing php libraries ****" && \
    cp .env.example .env && \
    composer install --no-dev --optimize-autoloader && \
    echo "**** Creating storage template ****" && \
    find storage -type d > .storage.tmpl && \
    echo "**** Cleaning up ****" && \
    composer clearcache && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /var/www/pterodactyl/.env \
        /var/www/pterodactyl/storage

# Local files.
COPY files/ /

# Ports and volumes.
EXPOSE 8080/tcp
VOLUME [ "/data" ]
