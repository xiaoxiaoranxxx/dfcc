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

#for 按空格||tab||回车分割,while 按回车,适合处理文件,会读空

#!/usr/bin/bash

ip=192.168.100.1
while ping -c -W1 $ip &>/dev/null
do
	sleep 1
done
echo "$ip is down"

until ping -c -W1 $ip &>/dev/null #与while相反
do
	sleep 1
done
echo "$ip is down"

for i in {1..100}
do
	let sum+=$i
done
echo "$sum"


#!/usr/bin/bash
for i in {2..254}
do
	{
		ip=192.168.122.$i
		ping -c1 -W1 $ip &>/dev/null
		if [ $? -eq 0 ];then
			echo "$ip up"
		fi
	}&
done
wait
echo "all finish..."

#!/usr/bin/bash
i=2
while [ $i -le 254 ]
do
	{
		ip=192.168.122.$i
		ping -c1 -W1 $ip &>/dev/null
		if [ $? -eq 0 ];then
			echo "$ip up"
		fi
	}&
	let i++
done
wait
echo "all finish..."

#!/usr/bin/bash
i=2
until [ $i -gt 254 ]
do
	{
		ip=192.168.122.$i
		ping -c1 -W1 $ip &>/dev/null
		if [ $? -eq 0 ];then
			echo "$ip up"
		fi
	}&
	let i++
done
wait
echo "all finish..."





