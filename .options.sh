#!/bin/bash

[ "${BASH_SOURCE[0]}" == "${0}" ] && {
    echo "FATAL | this script must be sourced!"
    exit 1
}


usage()
{
	echo "usage $(basename ${0}) [-d -p -c -l -s N -h]"
    echo "where:
        -d  : delete arp cache (requires root)
        -p  : refresh, ping all local network 192.168.1.*
        -c  : enable clear screen
        -l  : enable loop, and sleep 5
        -s N: set sleep time
        -h  : print this help and exits"
}


while getopts :dpcls:h option
do
	case $option in
		d)
			DELETE_CACHE=true;;
		p)
			PING_NETWORK=true;;
		c)
			CLEAR_SCREEN=true;;
		s)
			SLEEP_TIME=${OPTARG};;
		l)
			LOOP=true
			SLEEP_TIME=5
			;;
        h)
			usage
			exit
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
