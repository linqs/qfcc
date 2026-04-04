#!/bin/bash

readonly DOCKER_IMAGE_NAME='qfcc-judge'

readonly TEMP_DIR='/tmp/qfcc_docker_judge'

readonly CONTAINER_BASE_DIR='/judge'
readonly CONTAINER_INPUT_DIR="${CONTAINER_BASE_DIR}/input"
readonly CONTAINER_OUTPUT_DIR="${CONTAINER_BASE_DIR}/output"
readonly CONTAINER_ORACLE_DIR="${CONTAINER_BASE_DIR}/oracle"

function main() {
    if [[ $# -ne 2 ]]; then
        echo "USAGE: $0 <contestant submission dir> <oracle dir>"
        exit 101
    fi

    trap exit SIGINT
    set -e

    local submission_dir=$1
    local base_oracle_dir=$2

    rm -rf "${TEMP_DIR}"
    mkdir -p "${TEMP_DIR}"

    local input_dir="${TEMP_DIR}/input"
    mkdir -p "${input_dir}"
    cp -r "${submission_dir}/"* "${input_dir}/"

    local output_dir="${TEMP_DIR}/output"
    mkdir -p "${output_dir}"

    local oracle_dir="${TEMP_DIR}/oracle"
    cp -r "${base_oracle_dir}" "${oracle_dir}"

    docker run \
        --rm \
        --volume "${input_dir}:${CONTAINER_INPUT_DIR}:ro" \
        --volume "${output_dir}:${CONTAINER_OUTPUT_DIR}" \
        --volume "${oracle_dir}:${CONTAINER_ORACLE_DIR}:ro" \
        "${DOCKER_IMAGE_NAME}"

    return 0
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"
