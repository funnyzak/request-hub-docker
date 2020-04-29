# Request Hub Docker

[![Docker Stars](https://img.shields.io/docker/stars/funnyzak/request-hub.svg?style=flat-square)](https://hub.docker.com/r/funnyzak/request-hub/)
[![Docker Pulls](https://img.shields.io/docker/pulls/funnyzak/request-hub.svg?style=flat-square)](https://hub.docker.com/r/funnyzak/request-hub/)

This image is based on Alpine Linux image, which is a 144MB image. Base On [kyledayton/requesthub](https://github.com/kyledayton/requesthub) Project.



Download size of this image is:

[![](https://images.microbadger.com/badges/image/funnyzak/request-hub.svg)](http://microbadger.com/images/funnyzak/request-hub "Get your own image badge on microbadger.com")

[Docker hub image: funnyzak/request-hub](https://hub.docker.com/r/funnyzak/request-hub)

Docker Pull Command: `docker pull funnyzak/request-hub`

---

## Usage Example

Here is an example configuration of Docker and Docker Compse.

### Docker Run

```Docker
docker run -d --name request-hub --restart always \
-p 80:54321 funnyzak/request-hub
```

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
        - CONFIG_YML= #YAML Configuration File
        - NO_WEB=false #Disable the web UI
        - PORT=54321 # which port to bind to
        - MAX_REQUESTS=1024 # max requests to store
        - USER_NAME=hello # HTTP Basic Auth Username for accessing hub
        - PASSWORD=world # HTTP Basic Auth Password for accessing hub
    ports:
      - 80:54321
```

---

## Preview

![preview](https://raw.githubusercontent.com/funnyzak/request-hub-docker/master/preview.jpg)