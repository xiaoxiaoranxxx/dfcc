#!/usr/bin/bash

os_version=`cat /etc/redhat-release | awk '{print $4}' \
| awk -F"." '{print $1"."$2}'`

for i in {1..10} #`seq 1 10`
do
	{
	ip=192.168.100.$i
	ping -c1 -W1 $ip &>/dev/null
	if [ $? -eq 0 ];then
		echo "$ip" |tee -a ip.txt
	else 
		echo "null"
	fi
	}& #后台运行
done
wait #等后台运行
echo "ok"