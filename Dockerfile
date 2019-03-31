FROM node:alpine

MAINTAINER marcelo correia <marcelo@correia.io>

RUN apk update
RUN set -ex && apk add ca-certificates && update-ca-certificates && \
    apk add --no-cache --update \
    curl \
    unzip \
    bash \
    git \
    openssh \
    jq \
    make \
    tzdata

RUN rm /var/cache/apk/*

RUN mkdir -p /app
WORKDIR /app
RUN npm install -g try-thread-sleep
RUN npm install -g serverless --ignore-scripts spawn-sync
ENTRYPOINT ["serverless"]