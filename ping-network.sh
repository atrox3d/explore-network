#!/bin/bash

NETWORK=192.168.1

for addr in {1..255}
do
    echo "INFO | pinging ${NETWORK}.${addr} in BG..."
    ping ${NETWORK}.${addr} &> /dev/null &
done

echo "INFO | waiting for processes..."
wait
echo "INFO | done"
