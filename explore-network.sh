#!/bin/bash

HERE="$(dirname ${0})"
SCRIPT="$(basename ${0})"
SECRET="${HERE}/secret"

source "${HERE}/.functions.sh"
source "${HERE}/.defaults.sh"
source "${HERE}/.options.sh"

# delete arp cache as admin
${DELETE_CACHE} && delete_arp_cache

# ping every host in the network
${PING_NETWORK} && ping_network

MAIN_LOOP=true
while ${MAIN_LOOP}
do
	${CLEAR_SCREEN} && clear

	# print all globals
	dump_vars
	
	# run arp filter
	run_arp
	
	# wait for next loop, if looped
	[ $SLEEP_TIME -gt 0 ] && sleep_timer

	# update MAIN_LOOP with LOOP option
	MAIN_LOOP=${LOOP}
done
