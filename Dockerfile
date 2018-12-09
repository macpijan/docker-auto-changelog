FROM node:11.4.0-alpine

MAINTAINER Maciej Pijanowski <maciej.pijanowski@3mdeb.com>

RUN apk add git
RUN npm install -g auto-changelog

ENTRYPOINT ["auto-changelog"]
