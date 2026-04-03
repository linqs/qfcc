FROM debian:12.13-slim

ARG TIMEZONE="America/Los_Angeles"

ENV DEBIAN_FRONTEND=noninteractive

USER root

WORKDIR /work

# Base building packages.
RUN \
    apt update \
    && apt install -y \
        vim \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Configure base system.
RUN \
    ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

COPY ./scripts /work/scripts

ENTRYPOINT ["/work/scripts/judge-submission.sh"]
