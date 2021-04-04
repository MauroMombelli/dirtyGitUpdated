#!/bin/bash

PROGRAM="python main.py"

eval "$PROGRAM &"
PROGRAM_PID=$!
echo "Started pid $PROGRAM_PID"

while true
do
	echo "Checking updates"
	current=$(git rev-parse HEAD)
	git pull
	new=$(git rev-parse HEAD)

	if [ $current != $new ]; then
		echo "Update found, killing $PROGRAM_PID"
		kill $PROGRAM_PID
		sleep 2
		eval "$PROGRAM &"
		PROGRAM_PID=$!
		echo "RE-Started pid $PROGRAM_PID"
	fi
	
	sleep 30
done
