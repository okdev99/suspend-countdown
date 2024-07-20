#!/bin/bash

hibernate=false

case $1 in
	"")
		echo "Usage: $0 [-h] time"
		echo
		echo "  -h	hibernate instead of suspend"
		echo
		echo "If hibernating does not work, then the script will call to suspend."
		exit 0
		;;
	"-h")
		hibernate=true
		case $2 in
			*[!0-9]*)
				echo "The second argument was not a positive integer."
				exit 1
				;;
			*)
				countdown=$2
				;;
		esac
		;;
	*[!0-9]*)
		echo "The first argument was not a positive integer."
		exit 1
		;;
	*)
		countdown=$1
		;;
esac

echo "--  --  --"

while [ "$countdown" -gt 1 ]; do
    echo "Suspend in $countdown minutes."
    ((countdown--))
    sleep 60
done

if [ "$countdown" -eq 1 ]; then
	echo "Suspend in 1 minute."
	sleep 60
fi

if $hibernate; then
	echo "Hibernating now!"
	systemctl hibernate

	exit_code=$?
	if [ $exit_code != 0 ]; then
		echo "Suspending now!"
		systemctl suspend
	fi
else
	echo "Suspending now!"
	systemctl suspend
fi
