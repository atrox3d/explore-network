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

CLEAR_SCREEN=false
LOOP=false
SLEEP_TIME=0

while getopts :drcls: option
do
	case $option in
		d)
			echo "INFO | deleting arp cache as admin"
			gsudo arp -d
			;;
		r)
			echo "INFO | pinging network..."
			ping_network
			;;
		c)
			echo "INFO | enable CLEAR_SCREEN"
			CLEAR_SCREEN=true
			;;
		s)
			SLEEP_TIME=${OPTARG}
			echo "INFO | SLEEP_TIME: ${SLEEP_TIME}"
			;;
		l)
			echo "INFO | LOOP enabled"
			LOOP=true
			SLEEP_TIME=5
			;;
		\?)
			echo "ERROR | invalid option -${option}, exiting" >&2
			usage
			exit 1
			;;
		:)
			echo "ERROR | option ${option} requires an argument" >&2
			usage
			exit 2
			;;
	esac
done

MAIN_LOOP=true
while ${MAIN_LOOP}
do
	${CLEAR_SCREEN} && {
		clear
		echo "INFO | CLEAR_SCREEN enabled"
	}

	${LOOP} && {
		echo "INFO | LOOP enabled"
	}

	# *** ONELINER ***

	# filters arp output by:
	#   - local network (included)
	#   - list of macs (excluded)

	# the list of macs is filtered separating macs from comments

	# inside the process substitution:
	#   - transform tabs to spaces
    #   - squeezes multiple spaces into one
    #   - cuts line at the space
    #   - gets the first field
    #   - excludes lines containing '#'

	# cat secret/my-macs.txt | tr '\t' ' ' | tr -s ' ' | cut -d' ' -f1
	arp -a | \
	grep 192.168.1 | \
	grep -i -v -f \
	<(
		cat "${SECRET}"/my-macs.txt | \
		tr '\t' ' ' | \
		tr -s ' ' | \
		cut -d' ' -f1 | \
		grep -v '#'
	)

	[ $SLEEP_TIME -gt 0 ] && {
		echo "INFO | sleep ${SLEEP_TIME}"
		sleep ${SLEEP_TIME}
	}

	MAIN_LOOP=${LOOP}
done
