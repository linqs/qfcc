FROM debian:12.13-slim

ARG TIMEZONE="America/Los_Angeles"

ENV DEBIAN_FRONTEND=noninteractive

USER root

WORKDIR /work

RUN \
    ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

# Install Packages

COPY ./packages /work/packages

RUN \
    apt update \
    && cat /work/packages/base.list | xargs apt install --yes \
    && cat /work/packages/languages.list | xargs apt install --yes \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

COPY ./scripts /work/scripts

# Create the directory structure that should be mounted over.
RUN \
    mkdir -p \
        '/judge' \
        '/judge/input' \
        '/judge/output' \
        '/judge/oracle/input' \
        '/judge/oracle/output'

ENTRYPOINT ["/work/scripts/judge-submission.sh"]
CMD ["/judge"]
