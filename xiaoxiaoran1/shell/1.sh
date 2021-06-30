#!/usr/bin/bash

bash -vx 1.sh #调试

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
if [ $? -eq 0 ] ; then 
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

echo $1 $2 #位置变量

export  xiao=1 #环境变量
unset  xiao

$*所有参数  $@所有参数  $#参数个数 $$当前进程id $!上一个id  $0脚本名 $?上一个返回值


if [ $# -eq 0 ] ; then
        echo "usage: `basename $0` file no chan "
fi #是否有参数

if [ ! -f $1 ] ; then
		echo "error file"
fi  #文件

echo $1 $2

touch `date +%F`_file.txt
touch $(date +%F)_file.txt

expr 1 + 168
expr 11 \* 122

$((1*9))
$[1+1]

free -m|grep '^Mem:' |awk '{print $3}'


#!/usr/bin/bash
mem_use=`free -m|grep '^Mem:' |awk '{print $3}'`
mem_total=`free -m|grep '^Mem:' |awk '{print $2}'`
mem_p=$((mem_use*100/mem_total))
echo "this-->$mem_p%" # 内存占用

echo "2*34.33"|bc
echo "print 22.43/2.214"|python

url=www.xiaoxiaoran.com.cn
echo ${url}
echo ${url%.*}  #www.xiaoxiaoran.com
echo ${url%%.*} #www
echo ${url#*.xiao} #xiaoran.com.cn
echo ${url:0:5} #www.x
echo ${url:5:5} #iaoxi







