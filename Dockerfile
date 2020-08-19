FROM registry.access.redhat.com/ubi7/ubi-minimal:latest

LABEL name="PlanetScaleDB Operator mysqld stats exporter" \
      io.k8s.display-name="PlanetScaleDB Operator mysqld stats exporter" \
      maintainer="planetscaledboperator@planetscale.com" \
      vendor="PlanetScale, Inc." \
      version="0.12.1" \
      release="1" \
      summary="PlanetScaleDB Operator mysqld stats exporter" \
      description="PlanetScaleDB Operator mysqld stats exporter" \
      io.k8s.description="PlanetScaleDB Operator mysqld stats exporter" \
      distribution-scope="private" \
      url="https://planetscale.com"

COPY ./mysqld_exporter /bin/mysqld_exporter
RUN mkdir -p /licenses
COPY LICENSE /licenses

USER        nobody
EXPOSE      9104
ENTRYPOINT  [ "/bin/mysqld_exporter" ]
