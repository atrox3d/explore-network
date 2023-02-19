#!/bin/bash

[ "${BASH_SOURCE[0]}" == "${0}" ] && {
    echo "FATAL | this script must be sourced!"
    exit 1
}

case "$OSTYPE" in
	darwin*)  
		OS="macos"
		;; 
	linux*)   
		OS="linux"
		;;
	msys*|cygwin*)
		OS="windows"
		;;
	*)  
		OS="$OSTYPE"
		;;
esac	

OS_DIR="${HERE}/os/${OS}"
[ -d "${OS_DIR}" ] || {
	echo "ERROR | ${OS} unknown/not implemented" >&2
	exit 1
}

#
# os dependent functions
#
SOURCE_FILE="${OS_DIR}/.functions.sh"
echo "INFO | .loader.sh | loading ${SOURCE_FILE}"
source "${SOURCE_FILE}"

#
# common functions
#
SOURCE_FILE="${HERE}/.functions.sh"
echo "INFO | .loader.sh | loading ${SOURCE_FILE}"
source "${SOURCE_FILE}"


