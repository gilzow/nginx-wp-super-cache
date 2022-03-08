#!/usr/bin/env bash
if [[ -z ${1} ]]; then
	echo "I have to know what the plugin is to continue."
	exit 1;
fi

case ${1} in

  wp-super-cache)
    echo -n "supercache"
    ;;

  w3-total-cache)
    echo -n "page_enhanced"
    ;;

  wp-fastest-cache)
  	echo -n "all"
  	;;

  *)
    echo -n "${1}"
    ;;
esac

# Bash4
#declare -A cachingplugins
#cachingplugins=( ["wp-super-cache"]="supercache" ["wp-rocket"]="wp-rocket" ["w3-total-cache"]="page_enhanced" )
#echo "${cachingplugins[$1]}"

