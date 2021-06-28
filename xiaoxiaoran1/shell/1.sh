#!/usr/bin/bash


ping -c1 baidu.com && echo "xiaoxiaoran"

/usr/bin/python <<@@
print "xiaoxiao"
@@

echo sss

mkdir -pv /home/{333/{aaa,sss},444}
echo \*      #转义
touch 1.txt 2.txt
touch 1.txt\ 2.txt
