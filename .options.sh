#!/bin/bash

[ "${BASH_SOURCE[0]}" == "${0}" ] && {
    echo "FATAL | this script must be sourced!"
    exit 1
}


usage()
{
	echo "usage $(basename ${0}) [-d -p -c -l -s N]"
    echo "where:
        -d  : delete arp cache (requires root)
        -p  : refresh, ping all local network 192.168.1.*
        -c  : enable clear screen
        -l  : enable loop, and sleep 5
        -s N: set sleep time"
}


while getopts :dpcls: option
do
	case $option in
		d)
			echo "INFO | deleting arp cache as admin"
			gsudo arp -d
			;;
		p)
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
			echo "ERROR | invalid option -${OPTARG}, exiting" >&2
			usage
			exit 1
			;;
		:)
			echo "ERROR | option -${OPTARG} requires an argument" >&2
			usage
			exit 2
			;;
	esac
done
