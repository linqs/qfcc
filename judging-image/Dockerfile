FROM debian:12.13-slim

ARG TIMEZONE="America/Los_Angeles"

ENV DEBIAN_FRONTEND=noninteractive

USER root

WORKDIR /work

RUN \
    ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime

COPY ./packages /work/packages

# Install Base Packages
RUN \
    apt update \
    && cat /work/packages/base.list | xargs apt install --yes \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# Add Microsoft repo.
RUN \
    wget https://packages.microsoft.com/config/debian/12/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
    && dpkg -i packages-microsoft-prod.deb \
    && rm packages-microsoft-prod.deb

# Install Languages
RUN \
    apt update \
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
