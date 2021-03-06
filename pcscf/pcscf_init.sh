#!/bin/bash

while true; do
	echo 'Waiting for MySQL to start.'
	echo '' | nc -w 1 $MYSQL_IP 3306 && break
	sleep 1
done

sed -i 's|PCSCF_IP|'$PCSCF_IP'|g' /etc/kamailio_pcscf/kamailio_pcscf.cfg
sed -i 's|RTPENGINE_IP|'$RTPENGINE_IP'|g' /etc/kamailio_pcscf/kamailio_pcscf.cfg
sed -i 's|PCSCF_IP|'$PCSCF_IP'|g' /etc/kamailio_pcscf/pcscf.cfg
sed -i 's|MYSQL_IP|'$MYSQL_IP'|g' /etc/kamailio_pcscf/pcscf.cfg
sed -i 's|PCSCF_IP|'$PCSCF_IP'|g' /etc/kamailio_pcscf/pcscf.xml

ip r a 192.168.101.0/24 via $PGW_IP

/etc/init.d/kamailio_pcscf start
