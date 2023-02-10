#!/usr/bin/env bash

if [ x"$@" = x"quit" ]
then
		exit 0
elif [[ -n "$@"  ]] # -n : string length id greater than zero 
then
		nemo ~/fhnw/"$@"
		exit 0
fi

ls ~/fhnw/
echo "quit"
