#!/bin/bash

[ "${BASH_SOURCE[0]}" == "${0}" ] && {
    echo "FATAL | this script must be sourced!"
    exit 1
}

CLEAR_SCREEN=false
DELETE_CACHE=false
LOOP=false
SLEEP_TIME=0
PING_NETWORK=false

dump_vars()
{
    local DEFAULTS=(
        CLEAR_SCREEN
        LOOP 
        SLEEP_TIME
        DELETE_CACHE
        PING_NETWORK
        OSTYPE
    )
    local deafault
    for default in "${DEFAULTS[@]}"
    do
        # use indirection ${!varname} to get values
        printf 'INFO | %-15.15s: %s\n' "${default}" "${!default}"
    done
} >&2
