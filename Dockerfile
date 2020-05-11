FROM golang:alpine AS builder

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.vendor="potato<silenceace@gmail.com>" \
    org.label-schema.name="RequestHub" \
    org.label-schema.build-date="${BUILD_DATE}" \
    org.label-schema.description="RequestHub - Receive, Log, and Proxy HTTP requests. Base On: kyledayton/requesthub. which is a only 13.9MB image." \
    org.label-schema.docker.cmd="docker run -d --name request-hub -p 80:54321 funnyzak/request-hub" \
    org.label-schema.url="https://yycc.me" \
    org.label-schema.schema-version="1.0"	\
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-ref="${VCS_REF}" \
    org.label-schema.vcs-url="https://github.com/funnyzak/request-hub-docker" 

# install git
RUN apk add --no-cache git && \
    rm  -rf /tmp/* /var/cache/apk/*

# get and build requesthub
RUN go get github.com/kyledayton/requesthub

FROM funnyzak/alpine-glibc AS runner

COPY --from=builder /go/bin/requesthub /usr/local/bin

ENV LANG=C.UTF-8
# YAML Configuration File
ENV CONFIG_YML=
# Disable the web UI
ENV NO_WEB=false
# which port to bind to
ENV PORT=54321
# max requests to store
ENV MAX_REQUESTS=512
# HTTP Basic Auth Username for accessing hub
ENV USER_NAME=
# HTTP Basic Auth Password for accessing hub
ENV PASSWORD=

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]