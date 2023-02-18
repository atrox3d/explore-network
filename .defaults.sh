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
    echo "CLEAR_SCREEN: ${CLEAR_SCREEN}"
    echo "LOOP        : ${LOOP}"
    echo "SLEEP_TIME  : ${SLEEP_TIME}"
    echo "SECRET      : ${SECRET}"
} >&2
