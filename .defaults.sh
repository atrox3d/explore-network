#!/bin/bash

HERE="$(dirname ${BASH_SOURCE[0]})"
SECRET="${HERE}/secret"

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
