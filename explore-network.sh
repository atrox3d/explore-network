#!/bin/bash

HERE="$(dirname ${0})"
SCRIPT="$(basename ${0})"
SECRET="${HERE}/secret"

source "${HERE}/.functions.sh"
source "${HERE}/.defaults.sh"
source "${HERE}/.options.sh"


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
