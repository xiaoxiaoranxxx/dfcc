#!/usr/bin/bash

# if ! ping -c1 www.baidu.com &>/dev/null ;then
	# echo "connect false"
	# exit
# fi

ping -c1 www.baidu.com &>/dev/null

if [ $? -eq 0 ]; then
	yum -y install httpd
	systemctl start httpd
	systemctl enable httpd
	firewall-cmd --zone=public --add-port=80/tcp --permanent
	firewall-cmd --permanent --add-service=https
	firewall-cmd --reload
	firewall-cmd --list-ports
	
	curl http://127.0.0.1 &>/dev/null
	if [ $? -eq 0 ];then
		echo "apache ok"
	fi
	
elif ping -c1 10.0.4.8  &>/dev/null;then
	echo "check dns"
elif cat /etc/resolv.conf |grep nameserver;then
	echo "check "
else
	echo "check ip address"

fi



#vim /etc/httpd/conf/httpd.conf
