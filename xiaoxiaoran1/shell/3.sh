#!/usr/bin/bash
clear

#trap "" HUP INT OUIT TSTP

cat <<-@@
	+-------------------+
	|   xiaoxiaoran     |
	| 	1. ping         |
	| 	2. disk         |
	| 	3. filesystem   |
	| 	4. memory       |
	|	5. system       | 
	|   6. xiuxiu       |
	+-------------------+
@@
while :
do
	
	#read -p "please input a num-->" num
	echo -en "\e[1;32minput a num--> \e[0m"
	read num
	case "$num" in 
	1) 
		echo "ping-ping-ping"
		ping -c1 127.0.0.1
		;;
	2) 
		echo disk
		fdisk -l
		;;
	3) 
		echo df
		df -Th
		;;
	4) 
		echo free
		free -m
		;;
	5)
		echo "xiaoxiaoran666"
		;;
	exit)
		exit 
		;;
	"")
		;;
	*)
		echo "error ..."
	esac
done


