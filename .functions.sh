#!/bin/bash

[ "${BASH_SOURCE[0]}" == "${0}" ] && {
    echo "FATAL | this script must be sourced!"
    exit 1
}

ping_network()
{
    local NETWORK=192.168.1
    local addr
    for addr in {1..255}
    do
        echo "INFO | pinging ${NETWORK}.${addr} in BG..."
        ping ${NETWORK}.${addr} &> /dev/null &
    done

    echo "INFO | waiting for processes..."
    wait
    echo "INFO | done"
}

