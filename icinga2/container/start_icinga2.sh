#!/bin/bash
service icinga2 start
trap "systemctl stop icinga2" HUP INT QUIT ABRT ALRM TERM TSTP
while pgrep -u root icinga2 > /dev/null ; do sleep 5; done
