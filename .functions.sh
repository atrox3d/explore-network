#!/bin/bash

HERE="$(dirname ${BASH_SOURCE[0]})"
SECRET="${HERE}/secret"


usage()
{
	echo "usage $(basename ${BASH_SOURCE[0]}) [-d -r -c -l -s N]"
    echo "where:
        -d  : delete arp cache (requires root)
        -r  : refresh, ping all local network 192.168.1.*
        -c  : enable clear screen
        -l  : enable loop, and sleep 5
        -s N: set sleep time"
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

