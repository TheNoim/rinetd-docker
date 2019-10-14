#!/bin/sh

BIND_PORT=${PORT:=80}
TARGET__PORT=${TARGET_PORT:=80}

if [ -z ${TARGET_HOST+x} ]; 
then
	echo "You need to provide a target host"
	exit 1;
fi

echo "Target: $TARGET_HOST:$TARGET__PORT"
echo "Docker Port: $BIND_PORT"

echo "0.0.0.0 $BIND_PORT $TARGET_HOST $TARGET__PORT" > /etc/rinetd.conf

rinetd -f -c /etc/rinetd.conf