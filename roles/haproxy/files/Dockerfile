FROM haproxy:2.6.9-bullseye
USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    cron \
    curl \
    pv \
    netcat \
    && apt-get clean \
    && apt-get autoclean \
    && rm -rf /var/lib/apt/lists/*

COPY haproxy.cfg certificate.pem static.html /usr/local/etc/haproxy/

COPY script.sh /script.sh
RUN chmod 544 /script.sh
# Run from 7:30 till next day 1:30
RUN crontab -l | { cat; echo "* 4-22 * * * /bin/sh /script.sh >/proc/1/fd/1 2>/proc/1/fd/2"; } | crontab -

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 755 /usr/local/bin/docker-entrypoint.sh
