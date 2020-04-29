FROM golang:alpine

ARG BUILD_DATE
ARG VCS_REF

LABEL org.label-schema.vendor="potato<silenceace@gmail.com>" \
    org.label-schema.name="RequestHub" \
    org.label-schema.build-date="${BUILD_DATE}" \
    org.label-schema.description="RequestHub. Base On: https://github.com/kyledayton/requesthub" \
    org.label-schema.url="https://yycc.me" \
    org.label-schema.schema-version="1.0"	\
    org.label-schema.vcs-type="Git" \
    org.label-schema.vcs-ref="${VCS_REF}" \
    org.label-schema.vcs-url="https://github.com/funnyzak/request-hub-docker" 

# install git
RUN apk add --no-cache git && \
    rm  -rf /tmp/* /var/cache/apk/*

# install request hub
RUN go get github.com/kyledayton/requesthub/...

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

# export requesthub path
ENV PATH $GOPATH/bin:$PATH

ENTRYPOINT ["entrypoint.sh"]