#!/bin/bash

hibernate=false

if [[ $1 == "-h" ]]; then
	hibernate=true
	countdown=$2
elif [[ $1 == "" ]]; then
	echo "Usage: $0 [-h] time"
	echo
	echo "  -h	hibernate instead of suspend"
	echo
	echo "If hibernating does not work, then the script will call to suspend."
	exit 0
else
	countdown=$1
fi

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
