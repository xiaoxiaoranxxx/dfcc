#!/usr/bin/bash

info1==([name]=xiao [sex]=m [num]=666)
echo ${info1[name]}

array1=(tom jass alics)
array2=(`cat /etc/passwd`)
echo ${#info1[@]} #长度
echo ${!info1[@]} #索引
echo ${info1[@]:1:2} #切片


while read line
do
    hosts[++i]=$line
done </etc/hosts

for line in `cat /etc/hosts`
do
    hosts[++j]=$line
done


echo "hosts fist-->${hosts[1]}"
echo

for i in ${!hosts[@]}  #遍历
do
    echo "$i:${hosts[i]}"
done

