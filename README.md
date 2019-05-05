# pterodactyl-docker

## Panel

Run it once to generate a `pterodactyl.conf` file, which you have to update to provide the panel with your MySQL settings.

> Setting the `CREATE_ADMIN` environment variable to anything will make sure that a default admin:admin user is created for you. This will only work once unless you delete the `.adminlock` file created in the `/data` volume.

```
docker run -d \
  -p 8080:8080/tcp \
  -v /opt/pterodactyl-panel:/data \
  -e PUID=1000 \
  -e PGID=1000 \
  -e CREATE_ADMIN=yes \
  --name pterodactyl-panel \
  --restart=always \
  aeonlucid/pterodactyl-panel
```

## Daemon

If you change the `/srv/daemon-data` path, make sure you map it to the same path on the host. If it is different, it will not work.

Don't forget to put the (modified) `/srv/daemon-data` path in the `core.json` file at `sftp.path`.

```
docker run -d \
  -p 8080:8080/tcp \
  -v /srv/daemon-data:/srv/daemon-data \
  -v /srv/daemon/config:/srv/daemon/config \
  -v /srv/daemon/packs:/srv/daemon/packs \
  -v /tmp/pterodactyl:/tmp/pterodactyl \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker:/var/lib/docker \
  -e TZ=Europe/Amsterdam \
  -e PUID=1000 \
  -e PGID=1000 \
  --name pterodactyl-daemon \
  --restart=always \
  aeonlucid/pterodactyl-daemon
```

### Unraid

#### Docker

```
docker run -d \
  -p 8080:8080/tcp \
  -v /mnt/user/appdata/pterodactyl-daemon/data:/mnt/user/appdata/pterodactyl-daemon/data \
  -v /mnt/user/appdata/pterodactyl-daemon/config:/srv/daemon/config \
  -v /mnt/user/appdata/pterodactyl-daemon/packs:/srv/daemon/packs \
  -v /tmp/pterodactyl:/tmp/pterodactyl \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v /var/lib/docker:/var/lib/docker \
  -e TZ=Europe/Amsterdam \
  -e PUID=99 \
  -e PGID=100 \
  --name pterodactyl-daemon \
  --restart=always \
  aeonlucid/pterodactyl-daemon
```

#### Required core.json changes

| Key | Value |
|-|-|
| sftp.path | /mnt/user/appdata/pterodactyl-daemon/data |
| docker.timezone_path | /etc/localtime |
