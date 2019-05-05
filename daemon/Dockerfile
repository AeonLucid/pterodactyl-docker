FROM node:8-alpine

ENV VERSION=0.6.12 \
    PGID=1234 \
    PUID=1234 \
    TZ=Europe/Amsterdam

WORKDIR /srv/daemon

RUN \
 apk --update --no-cache add coreutils curl openssl make gcc g++ python gnupg tar shadow tzdata \
 && curl -sSL https://github.com/pterodactyl/daemon/releases/download/v$VERSION/daemon.tar.gz -o daemon.tar.gz \
 && tar --strip-components=1 -xzvf daemon.tar.gz \
 && rm -f daemon.tar.gz \
 && npm install --production \
 && addgroup -S pterodactyl \
 && adduser -S -D -H -G pterodactyl -s /bin/false pterodactyl \
 && apk del curl make gcc g++ python gnupg \
 && rm -rf /root/.npm /root/.node-gyp /root/.gnupg \
 /var/cache/apk/* /tmp/*

COPY files/ /

ENTRYPOINT [ "/docker-entrypoint.sh" ]
