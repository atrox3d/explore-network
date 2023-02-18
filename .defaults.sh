#!/bin/bash

[ "${BASH_SOURCE[0]}" == "${0}" ] && {
    echo "FATAL | this script must be sourced!"
    exit 1
}

CLEAR_SCREEN=false
LOOP=false
SLEEP_TIME=0

dump_vars()
{
    echo "INFO | CLEAR_SCREEN: ${CLEAR_SCREEN}"
    echo "INFO | LOOP        : ${LOOP}"
    echo "INFO | SLEEP_TIME  : ${SLEEP_TIME}"
    echo "INFO | SECRET      : ${SECRET}"
} >&2
