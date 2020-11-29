FROM golang:1.15-alpine AS build-env
WORKDIR /go/src/app
ENV  GO111MODULE=on
ENV  GOPROXY=https://goproxy.cn
COPY . .
RUN apk update && apk add git \
    && go build

FROM alpine:latest
RUN apk update && apk add ca-certificates  && rm -rf /var/cache/apk/*
COPY --from=build-env /go/src/app/demoapp /usr/bin/demoapp
ENTRYPOINT [ "/usr/bin/demoapp" ]