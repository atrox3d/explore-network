#!/bin/bash

[ "${BASH_SOURCE[0]}" == "${0}" ] && {
    echo "FATAL | this script must be sourced!"
    exit 1
}

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
