#!/bin/bash

HERE="$(dirname ${BASH_SOURCE[0]})"
SECRET="${HERE}/secret"

source "${HERE}/.functions.sh"
source "${HERE}/.defaults.sh"
dump_vars
exit

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
