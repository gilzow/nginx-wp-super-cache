#!/usr/bin/env bash

if [[ -z $1 ]]; then
	echo "all"
elif [[ "wp-super-cache" == "${1}" ]]; then
	echo "supercache"
elif [[ "wp-rocket" == "${1}" ]]; then
 	echo "wp-rocket"
elif [[ "w3-total-cache" == "${1}" ]]; then
	echo "page_enhanced"
fi

# Bash4
#declare -A cachingplugins
#cachingplugins=( ["wp-super-cache"]="supercache" ["wp-rocket"]="wp-rocket" ["w3-total-cache"]="page_enhanced" )
#echo "${cachingplugins[$1]}"

