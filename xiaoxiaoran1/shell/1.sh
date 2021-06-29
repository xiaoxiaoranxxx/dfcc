#!/usr/bin/bash


ping -c1 baidu.com && echo "xiaoxiaoran"
ping -c1 baidu.com &>/dev/null && echo "xiaoxiaoran" || echo die

/usr/bin/python <<@@
print "xiaoxiao"
@@

echo sss

mkdir -pv /home/{333/{aaa,sss},444}
echo \*      #转义
touch 1.txt 2.txt
touch 1.txt\ 2.txt

echo -e "\e[1;31mthis is red"
echo -e "\e[1;0mthis is null"
echo -e "\e[1;31mthis is red.\e[0m"
echo -e "\e[1;41mthis is red_b.\e[0m"

ip=192.168.0.1
ping -c2 $ip

if ping -c2 $ip &>/dev/null;then 
	echo "$ip is up"
else 
	echo "$ip is down"
fi

ping -c2 $ip &>/dev/null  
if[ $? -eq 0 ] ;then 
	echo "$ip is up"
else 
	echo "$ip is down"
fi

read -p "please input a ip-->"  ip
ping -c2 $ip 
if[ $? -eq 0 ] ; then 
	echo "$ip is up"
else 
	echo "$ip is down"
fi

echo $1 $2

export  xiao=1 #环境变量
unset  xiao


