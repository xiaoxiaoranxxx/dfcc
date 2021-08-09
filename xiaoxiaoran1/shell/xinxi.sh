#!/usr/bin/bash

ip=192.168.100.$1

ping -c2 $ip &>/dev/null  
if [ $? -eq 0 ] ; then 
	echo "$ip is up"
else 
	echo "$ip is down"
    exit
fi


masscan --rate=10000 --ports 0-65535 $ip 
masscan --rate=10000 --ports 0-65535 $ip 
nmap -A $ip
sleep 30
whatweb $ip 
sleep 10
dirsearch  -u  $ip 
sleep 5
nikto -h $ip 
sleep 5
dirb http://$ip 


