FROM debian:12.13-slim

ARG TIMEZONE="America/Los_Angeles"

ENV DEBIAN_FRONTEND=noninteractive

USER root

WORKDIR /work

RUN \
    apt update \
    && apt install -y \
        python3 \
        vim \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN \
    ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

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
