# kali linux

[在线速查](https://www.fujieace.com/linux/man/china-man.html)

```sh
sudo apt-get update &&sudo apt-get upgrade

which vim
	
sudo service apache2 start
	
firewall-cmd --zone=public --add-port=666/tcp --permanent; firewall-cmd --reload ;firewall-cmd --list-ports
	
alias fire='firewall-cmd --reload ;firewall-cmd --list-ports'
unalias fire
	
systemctl start httpd
systemctl enable httpd 
```
    

## 系统操作

```
du -sh 显示当前目录大小
du –sh / 显示/目录下的所有目录大小
df：列出文件系统的整体磁盘使用情况

查询登录主机的用户工具：w 、who 、users,last,uptime

ps aux
USER 表示启动进程用户。PID 表示进程标志号。%CPU 表示运行该进程占用 CPU 的时间与该进
程总的运行时间的比例。%MEM 表示该进程占用内存和总内存的比例。VSZ 表示占用的虚拟内存大
小，以 KB 为单位。RSS 为进程占用的物理内存值，以 KB 为单位。TTY 表示该进程建立时所对应的
终端，"?"表示该进程不占用终端。STAT 表示进程的运行状态，包括以下几种代码：D，不可中断的
睡眠；R，就绪（在可运行队列中）；S，睡眠；T，被跟踪或停止；Z，终止（僵死）的进程，Z 不
存在，但暂时无法消除；W，没有足够的内存分页可分配；<高优先序的进程；N，低优先序的进程；
L，有内存分页分配并锁在内存体内（实时系统或 I/O）。START 为进程开始时间。TIME 为执行的时
间。COMMAND 是对应的命令名。
父进和子进程的关系友好判断的例子 ps auxf |grep httpd
找出消耗内存最多的前 10 名进程 ps -auxf | sort -nr -k 4 | head -10 
找出使用 CPU 最多的前 10 名进程 ps -auxf | sort -nr -k 3 | head -10

	netstat -anp |grep 端口
	kill -9 PID   //关闭linux系统端口方法



pstree 命令列出当前的进程，以及它们的树状结构。

top 命令用来显示系统当前的进程状况。
```







	


