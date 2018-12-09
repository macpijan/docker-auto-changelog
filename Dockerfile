FROM node:11.4.0-alpine

RUN apk add git
RUN npm install -g auto-changelog

ENTRYPOINT ["auto-changelog"]
