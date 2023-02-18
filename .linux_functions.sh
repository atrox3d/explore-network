#!/bin/bash

[ "${BASH_SOURCE[0]}" == "${0}" ] && {
    echo "FATAL | this script must be sourced!"
    exit 1
}


ping_network()
{
    echo "INFO | pinging network..."
    local NETWORK=192.168.1
    local addr
    for addr in {1..255}
    do
        echo "INFO | pinging ${NETWORK}.${addr} in BG..."
        ping -n 1 ${NETWORK}.${addr} &> /dev/null &
    done

    echo "INFO | waiting for processes..."
    wait
    echo "INFO | done"
}

delete_arp_cache()
{
	echo "INFO | deleting arp cache as admin"
	gsudo arp -d
}

run_arp()
{
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
}
