ARG         CODENAME
FROM        debian:${CODENAME:-latest}
ENV         DEBIAN_FRONTEND=noninteractive
RUN         apt-get update \
            && apt-get upgrade --yes \
            && apt-get install --yes \
                build-essential \
                debmake \
                git-buildpackage \
                libtool \
                nano \
                quilt \
                reportbug \
                sudo \
                tzdata \
            && apt-get clean \
            && rm -rf /var/lib/apt/lists/*
ADD         init /usr/local/bin/init
RUN         chmod +x /usr/local/bin/init \
            && useradd --create-home --user-group --shell /bin/bash maintainer \
            && echo "maintainer     ALL=(ALL:ALL)   NOPASSWD: ALL" > /etc/sudoers.d/maintainer
ENTRYPOINT  ["/usr/local/bin/init"]
LABEL       org.opencontainers.image.authors="robin.alexander@netplus.ch"
USER        maintainer
WORKDIR     /home/maintainer
