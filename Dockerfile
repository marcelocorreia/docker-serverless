FROM node:9.4.0-alpine
MAINTAINER marcelo correia <marcelo@correia.io>
RUN apk update
RUN apk upgrade
RUN apk add ca-certificates && update-ca-certificates
RUN apk add --no-cache --update \
    curl \
    unzip \
    bash \
    python \
    py-pip \
    git \
    openssh \
    make \
    jq \
    tzdata

RUN pip install --upgrade pip
RUN pip install awscli

RUN mkdir -p /opt/workspace
RUN rm /var/cache/apk/*

WORKDIR /opt/workspace
RUN sudo npm install serverless -g
