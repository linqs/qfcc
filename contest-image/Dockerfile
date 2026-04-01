FROM debian:12.13-slim

ENV DEBIAN_FRONTEND=noninteractive

USER root

WORKDIR /work

# Base building packages.
RUN \
    apt update \
    && apt install -y \
        vim \
        live-build \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /work/user

# Copy Image Information
COPY ./packages /work/packages
COPY ./scripts /work/scripts
COPY ./data /work/data
COPY ./README.md /work/data/image-info.md

# Configure the Image
RUN \
    mkdir /build \
    && cd /build \
    && codename=$(cat /etc/os-release | grep VERSION_CODENAME | sed 's/^.*=//') \
    && lb config --distribution ${codename} --bootappend-live "boot=live components username=qfcc" \
    && mkdir /build/config/includes.chroot \
    && cp -r /work /build/config/includes.chroot/ \
    && cp /work/packages/base.list /build/config/package-lists/base.list.chroot \
    && cp /work/packages/editors.list /build/config/package-lists/editors.list.chroot \
    && cp /work/scripts/image-build-hook /build/config/hooks/normal/9999-image-build-hook.hook.chroot \
    && mkdir -p /build/config/includes.chroot/lib/live/config \
    && cp /work/scripts/image-boot-hook /build/config/includes.chroot/lib/live/config/9999-image-boot-hook \
    && mkdir -p /build/config/includes.chroot/opt/qfcc \
    && cp -r /work/data /build/config/includes.chroot/opt/qfcc/ \
    && mkdir -p /build/config/includes.chroot/etc/skel/Desktop \
    && cp -r /work/data/image-info.md /build/config/includes.chroot/etc/skel/Desktop/ \
    && cp -r /work/data/shortcuts/* /build/config/includes.chroot/etc/skel/Desktop/

ENTRYPOINT ["/work/scripts/entrypoint.sh"]
