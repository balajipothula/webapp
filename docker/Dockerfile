RUN apk update && apk upgrade && apk add --no-cache nginx-mod-http-lua nginx-mod-http-geoip nginx-mod-stream-geoip lua5.1-maxminddb lua5.1-socket sqlite-libs redis && ln /usr/lib/libsqlite3.so.0.* /usr/lib/libsqlite3.so && rm -rf /tmp/* /var/tmp/* /var/cache/apk/* /var/cache/distfiles/*
EXPOSE 8080

FROM alpine:3.22.1 AS NGINX1.28.0

LABEL \
  # Authors or maintainers of the image.
  org.opencontainers.image.authors="Balaji Pothula <balan.pothula@gmail.com>" \
  # Image reference of the image.
  org.opencontainers.image.base.name="alpine:3.22.1" \
  # Title or name for the image.
  org.opencontainers.image.title="nginx:1.28.0" \
  # Description or summary of the image.
  org.opencontainers.image.description="NGINX 1.28.0 - Reverse Proxy Server"

RUN \
  # Exit immediately if any command fails.
  set -e; \
  # Disable the interactive prompts and allows for automate.
  export DEBIAN_FRONTEND=noninteractive; \
  # Update the package lists for repositories.
  apt --yes --quiet update && \
  # Upgrade the packages.
  apt --yes --quiet upgrade && \
  # Install the required dependencies and packages.
  apt --yes --quiet install \
  certbot \
  locales && \
  # Remove the package files from the cache.
  apt --yes --quiet autoclean && \
  # Remove Debian based packages.
  rm -rf /var/lib/apt/lists/* && \
  # Update locale definition file, language English and localization US. 
  localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8

# Set default language English and localization US.
ENV LANG en_US.utf8

# Creates a mount point for persistent data in the container.
VOLUME ["/webapp"]

# Container will listen on port 443 using TCP.
EXPOSE 443/tcp