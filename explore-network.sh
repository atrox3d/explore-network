#!/bin/bash

HERE="$(dirname ${0})"
SCRIPT="$(basename ${0})"
SECRET="${HERE}/secret"

# load all functions
source "${HERE}/.loader.include"

# load globals
source "${HERE}/.defaults.include"

# parse command line options
source "${HERE}/.options.include"

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
