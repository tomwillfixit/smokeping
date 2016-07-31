#!/bin/sh

echo "Starting smokeping"
smokeping --config=/etc/smokeping/config --debug-daemon 

echo "Starting Lighttpd"
lighttpd -D -f /etc/lighttpd/lighttpd.conf

