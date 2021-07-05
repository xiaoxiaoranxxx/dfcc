#!/usr/bin/bash

# bash -n 6.sh

# for ip in `cat ip.txt`
# do 
# done

while :
do
	read -p "please prefix&passwd&num-->" prefix pass num

	printf "user info
	---------------------
	user prefix-->$prefix
	user password-->$pass
	user number-->$num
	---------------------
	"
	read -p "Are you sure?[y/n]-->" action
	if [ "$action" = "y" ] ; then
		break
	fi
done

echo "create user......"

for i in `seq -w $num`
do
	user=$prefix$i
	id $user &>/dev/null
	if [ $? -eq 0 ];then
		echo "user $user already exists"
	else
		useradd $user
		echo "$pass" |passwd --stdin $user &>/dev/null
		if [ $? -eq 0 ];then
			echo "$user is create"
		fi
	fi
done



