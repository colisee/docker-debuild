ARG         CODENAME
FROM        debian:${CODENAME:-latest}
ENV         DEBIAN_FRONTEND=noninteractive
ADD         entrypoint.sh /entrypoint.sh
RUN         apt-get update \
            && apt-get upgrade --yes \
            && apt-get install --yes \
                build-essential \
                debmake \
                devscripts \
                libtool \
                nano \
                pkg-config \
                quilt \
                reportbug \
                tzdata \
            && apt-get clean \
            && rm -rf /var/lib/apt/lists/* \
            && ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime \
            && chmod +x /entrypoint.sh
ENTRYPOINT  ["/entrypoint.sh"]
LABEL       org.opencontainers.image.authors="robin.alexander@netplus.ch"