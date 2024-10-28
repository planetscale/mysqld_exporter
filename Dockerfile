FROM --platform=$BUILDPLATFORM pscale.dev/wolfi-prod/go:1.23 AS build
ARG TARGETOS
ARG TARGETARCH
RUN apk --no-cache add curl
COPY . /mysqld_exporter
RUN rm -f /mysqld_exporter/mysqld_exporter
RUN CGO_ENABLED=0 GOOS="$TARGETOS" GOARCH="$TARGETARCH" make -C /mysqld_exporter build

FROM pscale.dev/wolfi-prod/base:latest
RUN apk --no-cache add curl jq
COPY --from=build /mysqld_exporter/mysqld_exporter /bin/mysqld_exporter
EXPOSE 9104
USER nobody
WORKDIR /
ENTRYPOINT ["/bin/mysqld_exporter"]
