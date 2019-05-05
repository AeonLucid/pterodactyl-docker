#!/bin/sh

# Update user and group id.
usermod -o -u "$PUID" pterodactyl
groupmod -o -g "$PGID" pterodactyl

# Fix permissions.
chown -R pterodactyl:pterodactyl /srv/daemon

# Fix timezone.
echo $TZ > /etc/timezone
rm -f /etc/localtime
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime
dpkg-reconfigure -f noninteractive tzdata

# Run.
npm start