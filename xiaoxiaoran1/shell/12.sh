#!/bin/bash
#/bin/sh
#/usr/bin/bash
#/usr/sh
#/bin/env bash

factor(){
factor=1
for((i=1;i<=$1;i++))
do 
	#factor=$[ $factor * $i ]
	#let factor=$factor*$i
	let factor*=$i
done
echo $factor
}


factor $1
factor $2
factor $3


fun2(){
read -p "enter num-->" num
return $[ 2*$num ] #<255
}
fun2
echo "fun2 return $?"   

fun2(){
read -p "enter num-->" num
echo $[ 2*$num ] 
}
result=`fun2`
echo "fun2 return $result"  


##########
if [ $# -ne 3 ];then
	echo "usage: `basename $0` p1 p2 p3"
	exit
fi
fun3(){
	echo "$(($1 * $2 * $3))"
}
result=`fun3 $1 $2 $3`
#result=`fun3 2 2 3`
echo $result

############

num=(1 2 3 4 5)
echo "${num[@]}"
array(){
	fa=1
	for i in "$@"
	do 
		fa=$[fa*$i]
	done
	echo "$fa"
}
array ${num[@]}
array ${num[*]}

############

num=(1 2 3 4 5)
array(){
	echo "all $*"
	local newarray=(`echo $*`)
	local i
	for ((i=0;i<$#;i++))
	do 
		outarray[$i]=$[ ${newarray[$i]} * 3 ]
	done
	echo "${outarray[*]}"
}

result=`array ${num[*]}`
echo ${result[*]}

############
for i in {A..G}
do
	echo -n $i
	for j in {1..9}
	do
		echo -n $j
	done
	echo
done

