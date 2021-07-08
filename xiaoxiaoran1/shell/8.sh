
ls /proc/$$/fd
	#0  1  2  255
	
ll /proc/$$/fd
	# lrwx------. 1 root root 64 7月   8 13:50 0 -> /dev/pts/1
	# lrwx------. 1 root root 64 7月   8 13:50 1 -> /dev/pts/1
	# lrwx------. 1 root root 64 7月   8 13:50 2 -> /dev/pts/1
	# lrwx------. 1 root root 64 7月   8 15:00 255 -> /dev/pts/1

touch file
exec 6<> file
ll /proc/$$/fd
	# lrwx------. 1 root root 64 7月   8 13:50 6 -> /home/shell/file

echo "1111" >> /proc/$$/fd/6

rm -rf file
ll /proc/$$/fd
	# lrwx------. 1 root root 64 7月   8 13:50 6 -> /home/shell/file (deleted)

exec 6<&- #关闭文件

# 管道也可以是一个文件

mkfifo /home/shell/xiao
file /home/shell/xiao 
	# xiao: fifo (named pipe)
rpm -qa > xiao
grep bash /home/shell/xiao
 
 
#!/usr/bin/bash

# ping multi thread

thread=5
tmp_fifofile=/tmp/$$.fifo

mkfifo $tmp_fifofile
exec 8<> $tmp_fifofile
rm $tmp_fifofile

for i in `seq $thread`
do
	echo >&8
done

for i in {1..254}
do
	read -u 8
	{
		ip=56.58.45.$i
		ping -c1 -W1 $ip &>/dev/null
		if [ $? -eq 0 ];then
			echo "$ip is up"
		else
			echo "$ip is down"
		fi
		echo >&8
	}&
done
wait
exec 8>&-
echo "xiuxiu..."
