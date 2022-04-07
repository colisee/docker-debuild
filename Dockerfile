ARG         DEBIAN_FRONTEND=noninteractive
FROM        debian:sid
RUN         apt-get update && apt-get upgrade --yes && \
            apt-get install --yes build-essential devscripts \
                libtool pkg-config quilt debmake reportbug nano && \
            apt-get clean && \
            rm -rf /var/lib/apt/lists/* && \
            ln -sf /usr/share/zoneinfo/Europe/Zurich /etc/localtime
ADD         entrypoint.sh /entrypoint.sh
RUN         chmod +x /entrypoint.sh
ENTRYPOINT  ["/entrypoint.sh"]
LABEL       org.opencontainers.image.authors="robin.alexander@netplus.ch"