#!/bin/bash

readonly INPUT_DIRNAME='input'
readonly OUTOUT_DIR='output'
readonly ORACLE_DIRNAME='oracle'

readonly SUBMISSION_BASENAME='solution'

readonly ALLOWED_EXTENSIONS=".c .cc .py"

function check_contents() {
    local baseDir=$1

    declare -A paths=(
        ['Base']="${baseDir}"
        ['Input']="${baseDir}/${INPUT_DIRNAME}"
        ['Output']="${baseDir}/${OUTPUT_DIRNAME}"
        ['Oracle Input']="${baseDir}/${ORACLE_DIRNAME}/${INPUT_DIRNAME}"
        ['Oracle Output']="${baseDir}/${ORACLE_DIRNAME}/${OUTPUT_DIRNAME}"
    )

    for name in "${!paths[@]}" ; do
        local path=${paths[${name}]}

        if [[ ! -d "${path}" ]] ; then
            echo "ERROR: ${name} directory does not exist or is not a directory: '${path}'."
            exit 2
        fi
    done

    local inputDir="${baseDir}/${INPUT_DIRNAME}"

    local numInputFiles=$(ls -1q "${inputDir}" | wc -l)
    if [[ ${numInputFiles} -ne 1 ]] ; then
        echo "ERROR: Expected exactly one input file, found ${numInputFiles}."
        exit 3
    fi

    local submissionPath=$(realpath "${inputDir}/"*)

    if [[ ! -f ${submissionPath} ]] ; then
        echo "ERROR: Submission file does not exist, or is not a file."
        exit 4
    fi

    local submissionBasename=$(basename "${submissionPath}" | sed 's/\(.*\)\(\.\w\+\)$/\1/')
    local submissionExtension=$(basename "${submissionPath}" | sed 's/\(.*\)\(\.\w\+\)$/\2/')

    if [[ "${SUBMISSION_BASENAME}" != "${submissionBasename}" ]] ; then
        echo "ERROR: Submission does not have the correct basename ('${SUBMISSION_BASENAME}'), found: '${submissionBasename}'."
        exit 5
    fi

    if [[ "${ALLOWED_EXTENSIONS}" != *"${submissionExtension}"* ]] ; then
        echo "ERROR: Submission does not have the correct extension, found: '${submissionExtension}'."
        exit 6
    fi
}

function main() {
    if [[ $# -ne 1 ]]; then
        echo "USAGE: $0 <base dir>"
        exit 1
    fi

    trap exit SIGINT
    set -e

    local baseDir=$1

    check_contents "${baseDir}"

    # TODO

    return 0
}

[[ "${BASH_SOURCE[0]}" == "${0}" ]] && main "$@"
