# QFCC Judging Image

This page covers the details of the image built for judges and the judging process.

## Overview

Submissions are judged using a script that runs inside a Docker container.
Submissions, input, and outputs will be mounted (read-only) to the Docker container, along with a mount for output.

A live image is provided so judges can optionally minimize the exposure of their host machine.

## Judging Procedure

 - (Optional) Boot into the judging image.
   - Since only Docker is required to run the judging script, running from your normal machine can work.
     However, this exposes a slightly larger security risk.
 - Receive USB
 - Record Contestant and Attempt Time
 - Plug in and Mount
 - Run Judging Script
 - If successful:
   - Then, record score and keep USB.
   - Otherwise, send back USB.

All winning submissions should be manually reviewed for any malicious behavior.
Be sure to check their previous submissions as well.

## Preparations

TODO

USBs
 - Need to booting machines and transfer solutions.
 - Booting USBs should stay with judges.
 - Transfer USBs should be marked and signed and dated (on tape).

## Security Notes

Below are some potential security issues and what you can do to mitigate them.

### Contestant Submits Malicious Code

This is mostly handled by running their code in a Docker container.

### Contestant Submits a Zip Bomb (or otherwise tries to consume all disk space)

The judging image constrains the disk size of the running container.

If you are not running the image, killing the container or rebooting the machine should be sufficient.

### Contestant Hands in a Malicious USB (e.g., USBKiller)

Make sure to inspect any USB before plugged in.
All transfer USBs should be signed and dated by a judge ahead of time.
Use of a non-signed USB is grounds for disqualification.
