#!/usr/bin/bash
read -p "please input a num" num
while true
do
	if [[ "$num" =~ ^[0-9]+$ ]] ; then
		break
	else
		echo "error num"
		read -p "please input a num-->" num
	fi
done  #判断数字

#!/usr/bin/bash
b_dir=/xiao/mysql
if [ ! -d $b_dir ];then
	mkdir -p $b_dir
fi  #判断文件夹

[ ! -d /ccc  ] ;echo $?

#!/usr/bin/bash
read -p "please input a username" uname
id $uname &>/dev/null
if [ $? -eq 0 ] ; then
	echo "$uname is exists..."
else 
	useradd $uname
	if [ $? -eq 0 ] ; then
		echo "$uname is created"
	fi
fi  #创建用户


#!/usr/bin/bash

#df -Th|grep '/$'|awk '{print $(NF-1)}'|awk -F"%" '{print $1}'  //95%

disk_use=`df -Th|grep '/$'|awk '{print $(NF-1)}'|awk -F"%" '{print $1}'` #95
if [ $disk_use -ge 90  ];then
	echo "`date +%F-%H ` disk:${disk}%"
fi  #磁盘检测

#!/usr/bin/bash

read -p "please input a num-->" num
if [[ ! "$num" =~ ^[0-9]+$ || "$num" =~ ^0+$ ]];then
	echo "error num"
	exit
fi

read -p "please input a prefix-->" prefix
if [ -z "$prefix" ];then
	echo "echo prefix"
	exit
fi

for i in `seq $num`
do
	user=$prefix$i
	useradd $user
	echo "xiao666" | passwd --stdin $user &>/dev/null
	if [ $? -eq 0 ];then
		echo "$user is created."
	fi
	
done  #批创建用户


[ 1 -lt 2 -a 5 -gt 10 ];echo $?
[ 1 -lt 2 -o 5 -gt 10 ];echo $?
[[ 1 -lt 2 && 5 -gt 10 ]];echo $?
[[ 1 -lt 2 || 5 -gt 10 ]];echo $?


#!/usr/bin/bash
read -p "please input a name-->" user
id $user &>/dev/null
if [ $? -ne 0 ];then
	echo "not such $user" 
	exit 1
fi
read -p "Are you sure?[y/n]-->" action
if [ "$action" = "y" ];then
	userdel -r $user
	echo "echo ok kill"
else
	echo "false"
fi  #删除用户



