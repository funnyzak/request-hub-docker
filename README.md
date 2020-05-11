# Request Hub Docker

Receive, Log, and Proxy HTTP requests. Base On [kyledayton/requesthub](https://github.com/kyledayton/requesthub)

[![Docker Stars](https://img.shields.io/docker/stars/funnyzak/request-hub.svg?style=flat-square)](https://hub.docker.com/r/funnyzak/request-hub/)
[![Docker Pulls](https://img.shields.io/docker/pulls/funnyzak/request-hub.svg?style=flat-square)](https://hub.docker.com/r/funnyzak/request-hub/)

This image is based on Alpine Linux image, which is a only **13.9MB** image.

Download size of this image is:

[![](https://images.microbadger.com/badges/image/funnyzak/request-hub.svg)](http://microbadger.com/images/funnyzak/request-hub "Get your own image badge on microbadger.com")

[Docker hub image: funnyzak/request-hub](https://hub.docker.com/r/funnyzak/request-hub)

Docker Pull Command: `docker pull funnyzak/request-hub`

---

## Environment

The following are the environment variables for a requesthub:

__You should consider the [use of `--env-file=`](https://docs.docker.com/engine/reference/commandline/run/#set-environment-variables--e---env---env-file), [docker secrets](https://docs.docker.com/engine/swarm/secrets/) to keep your secrets out of your shell history__

* **CONFIG_YML**: RequestHub can create default hubs on startup. Simply create a YAML file with the appropriate hub names and forwarding urls, and pass it to the config option. Optional.
* **NO_WEB**: Whether to Disable the web UI. Defaults to false. Optional.
* **PORT**: which port to bind to. Defaults to 54321. Optional.
* **MAX_REQUESTS**: max requests to store. Defaults to 512. Optional.
* **USER_NAME**: HTTP Basic Auth Username for accessing hub. Optional.
* **PASSWORD**: HTTP Basic Auth Password for accessing hub. Optional.

**Config_YML** Demo:

```yaml
hubs:
  test-hub:
    forward_url: 'https://www.example.com/webhook'
  another-hub:
    forward_url: 'https://www.example.com/webhook2'
```

---

## Usage Example

To run a requesthub, launch `requesthub` image as a container with the correct parameters. Everything is controlled by environment variables passed to the container.

For example:

```bash
docker run -d --name request-hub --restart always \
-p 80:54321 funnyzak/request-hub
```

Or, if you prefer compose:

### Docker-Compose

```docker
version: '3'
services:
  requesthub:
    image: funnyzak/request-hub
    container_name: requesthub
    restart: always
    logging:
      driver: "json-file"
      options:
        max-size: "1g"
    environment:
        - TZ=Asia/Shanghai
        - LANG=C.UTF-8
        - CONFIG_YML=/config.yml
        - NO_WEB=false
        - PORT=54321
        - MAX_REQUESTS=1024
        - USER_NAME=hello
        - PASSWORD=world
    volumes:
      - ./config.yml:/config.yml
    ports:
      - 80:54321
```

---

## Preview

![preview](https://raw.githubusercontent.com/funnyzak/request-hub-docker/master/preview.jpg)

---

## Automated Build

This github repo is the source for the requesthub image. The actual image is stored on the docker hub at `funnyzak/requesthub`, and is triggered with each commit to the source by automated build via Webhooks.

There are 2 builds: 1 for version based on the git tag, and another for the particular version number.
