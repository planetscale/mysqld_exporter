FROM --platform=$BUILDPLATFORM golang:bookworm AS build
ARG TARGETOS
ARG TARGETARCH
RUN apt-get -y install make
COPY . /mysqld_exporter
RUN rm -f /mysqld_exporter/mysqld_exporter
RUN CGO_ENABLED=0 GOOS="$TARGETOS" GOARCH="$TARGETARCH" make -C /mysqld_exporter build

FROM golang:alpine
COPY --from=build /mysqld_exporter/mysqld_exporter /bin/mysqld_exporter
EXPOSE 9104
USER nobody
ENTRYPOINT ["/bin/mysqld_exporter"]
