#!/usr/bin/bash

if [ $# -eq 0 ] ; then
	echo "usage:`basename $0` file"
	exit 1
fi

if [ ! -f $1 ]; then
	echo "erorr file"
	exit 2
fi

for user in `cat $1`
do
	if [ ${#user} -eq 0 ];then
		continue
	fi
	echo $user
done

#!/usr/bin/bash

for ip in `cat ip.txt`
do
	ssh $ip "grep 'DNS' /etc/ssh/sshd_config "
done








