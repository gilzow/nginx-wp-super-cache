#!/usr/bin/env bash
advancedCacheFile="wordpress/wp-content/cache-config/advanced-cache.php"

# checks to see if the existing advanced-cache.php file is the one provided by the current caching plugin. if not, we
# remove the copy then rsync the one from the plugin
function testownership() {
	pattern=$1
	location=$2
	contents=$(head -n 5 "${advancedCacheFile}")
	if [[ ! "${contents}" =~ ${pattern} ]]; then
		#they dont own it, so remove the existing, then copy over theirs IF theirs actually exists
		if [[ -f "${location}" ]]; then
			rm "${advancedCacheFile}"
			syncPluginCopy "${location}"
		else
			badSourceFile "${location}"
			exit 1;
		fi
	fi
}

function badSourceFile(){
	source=$1
	printf "The source file you indicated does not exist.\n%s\n" "${location}"
}

# syncs the copy of advanced-cache.php provided by the plugin into /cache-config
function syncPluginCopy() {
    location=$1
    if [[ -f "${location}" ]]; then
    	rsync -a "${location}" "${advancedCacheFile}"
    else
    	badSourceFile "${location}"
    	exit 1
    fi
}

case ${CACHEPLUGIN} in

  wp-super-cache)
    superCacheAC="wordpress/wp-content/plugins/wp-super-cache/advanced-cache.php"
		#super cache needs it's file copied over or it'll complain
		if [[ -f "${advancedCacheFile}" ]]; then
			testownership "WP SUPER CACHE" "${superCacheAC}"
			if ( 1 == $? ); then
				exit 1;
			fi
		else
			syncPluginCopy "${superCacheAC}"
		fi

		#now we need to make sure we have a copy of wp-cache-config
		if [[ ! -f "wordpress/wp-content/cache-config/wp-cache-config.php" ]]; then
			cp wordpress/wp-content/plugins/wp-super-cache/wp-cache-config-sample.php wordpress/wp-content/cache-config/wp-cache-config.php
		fi
		;;

  w3-total-cache)
  	totalCacheAC="wordpress/wp-content/plugins/w3-total-cache/wp-content/advanced-cache.php"
  	if [[ -f "${advancedCacheFile}" ]]; then
  		testownership "W3 Total Cache" "${totalCacheAC}"
			if (( 1 == $? )); then
				exit 1;
			fi
  	else
  		syncPluginCopy "${totalCacheAC}"
  	fi

		# we also need to check if

    ;;

  #wp-fastest-cache)
  	#echo -n "all"
  	#;;

  *)
  	if [ ! -f "${advancedCacheFile}" ]; then
    	touch "${advancedCacheFile}"
    fi
    ;;
esac
