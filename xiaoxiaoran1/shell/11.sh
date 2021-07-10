#!/usr/bin/bash

cat set.txt

	# ja m
	# ps f
	# rr f
	# eee m

awk '{print $2}' sex.txt |sort |uniq -c 

declare -A sex
while read line
do
	type=`echo $line |awk '{print $2}'`
	let sex[$type]++
done < sex.txt

for i in ${!sex[@]}
do
	echo "$i: ${sex[$i]}"
done



awk -F ":" '{print $NF}' /etc/passwd |sort |uniq -c

cat /etc/passwd

declare -A shells
while read line
do
	type=`echo $line |awk -F ":" '{print $NF}' `
	let shells[$type]++
done </etc/passwd

for i in ${!shells[@]}
do
	echo "$i: ${shells[$i]}"
done


ss -an

declare -A status
type=`ss -an |awk '{print $2}' `

for i in $type
do
	let status[$i]++
done
for j in ${!status[@]}
do
	echo "$j: ${status[$j]}"
done

watch -n1 ./1.sh #动态看

while :
do
	...
	sleep 1
	clear
done


