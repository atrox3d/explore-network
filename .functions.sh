#!/bin/bash

[ "${BASH_SOURCE[0]}" == "${0}" ] && {
    echo "FATAL | this script must be sourced!"
    exit 1
}

SOURCE_FILE="NOT IMPLEMENTED"
case "$OSTYPE" in
	darwin*)  
		# echo "OSX"
		SOURCE_FILE="${HERE}/.linux_functions.sh"
		;; 
	linux*)   
		# echo "LINUX"
		SOURCE_FILE="${HERE}/.linux_functions.sh"
		;;
	msys*|cygwin*)
		# echo "WINDOWS"
		SOURCE_FILE="${HERE}/.win_functions.sh"
		;;
	solaris*|bsd*) 
		echo "NOT IMPLEMENTED"
		;;
	*)  
		echo "unknown: $OSTYPE"
		;;
esac	

source "$SOURCE_FILE"

sleep_timer()
{
    echo "INFO | sleep ${SLEEP_TIME}"
    sleep ${SLEEP_TIME}
}
