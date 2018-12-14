#!/bin/bash
#
# Start des Services

pidfile="/var/run/dhcpd.pid";

# ----------------------------------------------------------------------------------------------

function stopService {
	if [ -f "$pidfile" ]; then
		kill -15 $(cat "$pidfile");
	fi;
	
	# Die vergebenen Leases retten
	cp -p /var/lib/dhcp/dhcpd.leases /docker/output;
	
	return 0;
}

# ----------------------------------------------------------------------------------------------

# per Trap wird der Dienst wieder heruntergefahren
trap 'stopService; exit $?' EXIT SIGINT SIGKILL SIGTERM

# Der DHCP-Dämon wird gestartet
#/usr/sbin/dhcpd

# Auf das Beenden des DHCP-Daemons warten
#sleep 100;
#if [ -f "$pidfile" ]; then
#	waitPID=$(cat "$pidfile");
#	while ps aux | grep "$pidfile" 2>/dev/null >/dev/null; do
#		sleep 10;
#	done;
#else
#	echo "PID-File '$pidfile' ist nicht vorhanden";
#fi;
