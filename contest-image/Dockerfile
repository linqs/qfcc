FROM debian:12.13-slim

ARG TIMEZONE="America/Los_Angeles"

ARG BOOT_MENU_TIMEOUT="30"
ARG BOOT_MENU_TITLE="Quality First Coding Competition"

ENV DEBIAN_FRONTEND=noninteractive

USER root

WORKDIR /work

# Base building packages.
RUN \
    apt update \
    && apt install -y \
        tree \
        vim \
        live-build \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /work/user

# Copy Image Information
COPY ./packages /work/packages
COPY ./scripts /work/scripts
COPY ./data /work/data
COPY ./README.md /work/data/text/SYSTEM-INFO.md
COPY ./HINTS.md /work/data/text/HINTS.md

# Create a seed that can be used for things like passwords.
RUN \
    shuf -i 1-1000000000 -n 1 > /work/data/SEED \
    && echo "Seed: $(cat /work/data/SEED)"

# Base Configure
RUN \
    mkdir /build \
    && cd /build \
    && codename=$(cat /etc/os-release | grep VERSION_CODENAME | sed 's/^.*=//') \
    && lb config \
        --binary-images iso-hybrid \
        --distribution ${codename} \
        --archive-areas "main contrib non-free non-free-firmware" \
        --bootappend-live "boot=live toram timezone=${TIMEZONE} components hostname=qfcc username=qfcc" \
        --cache false --cache-indices false --cache-packages false --cache-stages false

# Copy the main work directory so scripts can reference it.
RUN \
    mkdir -p /build/config/includes.chroot \
    && cp -r /work /build/config/includes.chroot/

# Package Information
RUN \
    mkdir -p /build/config/package-lists \
    && cp /work/packages/base.list /build/config/package-lists/base.list.chroot \
    && cp /work/packages/editors.list /build/config/package-lists/editors.list.chroot

# Hook Scripts
RUN \
    mkdir -p /build/config/hooks/normal /build/config/includes.chroot/lib/live/config \
    && cp /work/scripts/image-build-hook /build/config/hooks/normal/9999-image-build-hook.hook.chroot \
    && cp /work/scripts/image-boot-hook /build/config/includes.chroot/lib/live/config/9999-image-boot-hook

# Data Directory
RUN \
    mkdir -p /build/config/includes.chroot/opt/qfcc \
    && cp -r /work/data /build/config/includes.chroot/opt/qfcc/ \
    && cp -r /work/packages/remove-force.txt /build/config/includes.chroot/opt/qfcc/data/

# Shortcuts
RUN \
    mkdir -p /build/config/includes.chroot/etc/skel/Desktop \
    && cp -r /work/data/text/* /build/config/includes.chroot/etc/skel/Desktop/ \
    && cp -r /work/data/shortcuts/* /build/config/includes.chroot/etc/skel/Desktop/

# Bootloader
RUN \
    mkdir -p /build/config/bootloaders \
    && cp -r /usr/share/live/build/bootloaders/isolinux /build/config/bootloaders/ \
    && cp -r /usr/share/live/build/bootloaders/syslinux /build/config/bootloaders/ \
    && cp -r /usr/share/live/build/bootloaders/syslinux_common /build/config/bootloaders/ \
    && rm /build/config/bootloaders/syslinux_common/splash.svg \
    && cp /work/data/images/linqs-slug-text-boot.png /build/config/bootloaders/syslinux_common/splash.png \
    && cp /work/data/images/linqs-slug-text-boot-800x600.png /build/config/bootloaders/syslinux_common/splash800x600.png \
    && sed -i "s/timeout 0/timeout ${BOOT_MENU_TIMEOUT}/" \
        /build/config/bootloaders/syslinux/syslinux.cfg \
        /build/config/bootloaders/isolinux/isolinux.cfg \
    && sed -i "s/menu title Boot menu/menu title ${BOOT_MENU_TITLE}/" /build/config/bootloaders/syslinux_common/menu.cfg

ENTRYPOINT ["/work/scripts/entrypoint.sh"]
