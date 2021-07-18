#!/bin/bash

for i
do
	let sum+=$i
done
echo "$sum" 

while [ $# -ne 0 ]
do
	let sum+=$1
	shift  #左移
done
echo "$sum"  #求所有参数的和

#任意数字
[[ "$num" =~ ^[0-9]+$ ]] && echo "ok" || echo "no"

grep '^root' /etc/passwd /etc/shadow

grep -v '^#' /etc/passwd

egrep -o '([0-9]{1,3}\.){3}[0-9]{1,3}' /etc/sysconfig/network-scripts/*
egrep -R '([1-9]{1,3}\.){3}[0-9]{1,3}' /etc/sysconfig/*

sed -i 'd' 1.sh 

sed -r 's/(.*)(.)/\1YYY\2/' /etc/passwd
sed -r '2,6s/^/#/' 1.sh
sed -ri '1,6s/^#*/#/' 1.sh 
sed -ri '1,6s/^[ \t]*#*/#/' 1.sh 

awk -F ":" '{print $1}' /etc/passwd
awk -F ":" '{print FNR, $1}' /etc/passwd
awk -F ":" '{print $1,$NF}' /etc/passwd
awk -F "[ :\t]" '{print $1}' /etc/passwd
awk -F ":" '{printf "%-15d %-10s %-25s\n" ,$1,$2,$3}' /etc/passwd
awk -F ":" '{ if(){$1>1} print $1 else{} }' /etc/passwd
awk -F "[ :]+" '{print NF}' 1.txt

