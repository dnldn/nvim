#!/bin/bash
if printenv | grep -q SSH_CONNECTION;
then
	echo "1"
else
	echo "0"
fi
