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

## 命令

```
Ctrl + u 清除剪切光标之前的内容
Ctrl + k 剪切清除光标之后的内容
Ctrl + y 粘贴刚才所删除的字符
Ctrl + r 在历史命令中查找
Alt + d 剪切光标之后的词
Ctrl+s 锁住终端
Ctrl+q 解锁终端
!! 重复执行最后一条命令

Alt + F1 类似 Windows 下的 Win 键，在 GNOME 中打开"应用程序"菜单(Applications)
Alt + F2 类似 Windows 下的 Win + R 组合键，在 GNOME 中运行应用程序
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

##  文件操作

```
cd 进入个人的主目录 
cd - 返回上次所在的目录 
pwd 显示工作路径 
ls 查看目录中的文件 
ls -F 查看目录中的文件 
ls -l 显示文件和目录的详细资料 
ls -a 显示隐藏文件 
mkdir dir1 创建一个叫做 'dir1' 的目录' 
mkdir dir1 dir2 同时创建两个目录 
mkdir -p /tmp/dir1/dir2 创建一个目录树 
rm -f file1 删除一个叫做 'file1' 的文件' 
rmdir dir1 删除一个叫做 'dir1' 的目录' 
rm -rf dir1 删除一个叫做 'dir1' 的目录并同时删除其内容 
rm -rf dir1 dir2 同时删除两个目录及它们的内容 
mv dir1 new_dir 重命名/移动 一个目录 
cp file1 file2 复制一个文件 
cp dir/* . 复制一个目录下的所有文件到当前工作目录 
cp -a /tmp/dir1 . 复制一个目录到当前工作目录 
cp -a dir1 dir2 复制一个目录 
cp -r dir1 dir2 复制一个目录及子目录
ln -s file1 lnk1 创建一个指向文件或目录的软链接 
ln file1 lnk1 创建一个指向文件或目录的物理链接 
touch -t 0712250000 file1 修改一个文件或目录的时间戳 - (YYMMDDhhmm) 
iconv -l 列出已知的编码 

find / -name file1 从 '/' 开始进入根文件系统搜索文件和目录 
find /home/user1 -name \*.bin 在目录 '/ home/user1' 中搜索带有'.bin' 结尾的文件 
find /usr/bin -type f -atime +100 搜索在过去100天内未被使用过的执行文件 
find /usr/bin -type f -mtime -10 搜索在10天内被创建或者修改过的文件 
find / -name \*.rpm -exec chmod 755 '{}' \; 搜索以 '.rpm' 结尾的文件并定义其权限 
find / -xdev -name \*.rpm 搜索以 '.rpm' 结尾的文件，忽略光驱、捷盘等可移动设备 
locate \*.ps 寻找以 '.ps' 结尾的文件 - 先运行 'updatedb' 命令 
whereis halt 显示一个二进制文件、源码或man的位置 
which halt 显示一个二进制文件或可执行文件的完整路径 
```






	groupadd group_name 创建一个新用户组 
	groupdel group_name 删除一个用户组 
	groupmod -n new_group_name old_group_name 重命名一个用户组 
	useradd -c "Name Surname " -g admin -d /home/user1 -s /bin/bash user1 创建一个属于 "admin" 用户组的用户 
	useradd user1 创建一个新用户 
	userdel -r user1 删除一个用户 ( '-r' 排除主目录) 
	usermod -c "User FTP" -g system -d /ftp/user1 -s /bin/nologin user1 修改用户属性 
	passwd 修改口令 
	passwd user1 修改一个用户的口令 (只允许root执行) 
	chage -E 2005-12-31 user1 设置用户口令的失效期限 
	pwck 检查 '/etc/passwd' 的文件格式和语法修正以及存在的用户 
	grpck 检查 '/etc/passwd' 的文件格式和语法修正以及存在的群组 
	newgrp group_name 登陆进一个新的群组以改变新创建文件的预设群组 


	ls -lh 显示权限 
	ls /tmp | pr -T5 -W$COLUMNS 将终端划分成5栏显示 
	chmod ugo+rwx directory1 设置目录的所有人(u)、群组(g)以及其他人(o)以读（r ）、写(w)和执行(x)的权限 
	chmod go-rwx directory1 删除群组(g)与其他人(o)对目录的读写执行权限 
	chown user1 file1 改变一个文件的所有人属性 
	chown -R user1 directory1 改变一个目录的所有人属性并同时改变改目录下所有文件的属性 
	chgrp group1 file1 改变文件的群组 
	chown user1:group1 file1 改变一个文件的所有人和群组属性 
	find / -perm -u+s 罗列一个系统中所有使用了SUID控制的文件 
	chmod u+s /bin/file1 设置一个二进制文件的 SUID 位 - 运行该文件的用户也被赋予和所有者同样的权限 
	chmod u-s /bin/file1 禁用一个二进制文件的 SUID位 
	chmod g+s /home/public 设置一个目录的SGID 位 - 类似SUID ，不过这是针对目录的 
	chmod g-s /home/public 禁用一个目录的 SGID 位 
	chmod o+t /home/public 设置一个文件的 STIKY 位 - 只允许合法所有人删除文件 
	chmod o-t /home/public 禁用一个目录的 STIKY 位 
```	
1、*.tar 用 tar –xvf 解压
2、*.gz 用 gzip -d 或者 gunzip 解压
3、*.tar.gz 和*.tgz 用 tar –xzf 解压
4、*.bz2 用 bzip2 -d 或者用 bunzip2 解压
5、*.tar.bz2 用 tar –xjf 解压
6、*.Z 用 uncompress 解压
7、*.tar.Z 用 tar –xZf 解压
8、*.rar 用 unrar e 解压
9、*.zip 用 unzip 解压
```

	YUM 软件包升级器 - （Fedora, RedHat及类似系统） 
	yum install package_name 下载并安装一个rpm包 
	yum localinstall package_name.rpm 将安装一个rpm包，使用你自己的软件仓库为你解决所有依赖关系 
	yum update package_name.rpm 更新当前系统中所有安装的rpm包 
	yum update package_name 更新一个rpm包 
	yum remove package_name 删除一个rpm包 
	yum list 列出当前系统中安装的所有包 
	yum search package_name 在rpm仓库中搜寻软件包 
	yum clean packages 清理rpm缓存删除下载的包 
	yum clean headers 删除所有头文件 
	yum clean all 删除所有缓存的包和头文件 
	列出所有可安装的软件包命令：yum list


	apt-get install package_name 安装/更新一个 deb 包 
	apt-cdrom install package_name 从光盘安装/更新一个 deb 包 
	apt-get update 升级列表中的软件包 
	apt-get upgrade 升级所有已安装的软件 
	apt-get remove package_name 从系统删除一个deb包 
	apt-get check 确认依赖的软件仓库正确 
	apt-get clean 从下载的软件包中清理缓存 
	apt-cache search searched-package 返回包含所要搜索字符串的软件包名称 


	cat file1 从第一个字节开始正向查看文件的内容 
	tac file1 从最后一行开始反向查看一个文件的内容 
	more file1 查看一个长文件的内容 
	less file1 类似于 'more' 命令，但是它允许在文件中和正向操作一样的反向操作 
	head -2 file1 查看一个文件的前两行 
	tail -2 file1 查看一个文件的最后两行 
	tail -f /var/log/messages 实时查看被添加到一个文件中的内容 


	/usr 目录包含所有的命令、程序库、文档和其它文件。这些文件在正常操作中不会被改变的
	/var 目录包含在正常操作中被改变的文件：假脱机文件、记录文件、加锁文件、临时文件和页格式化文件等。这个目录中存放着那些不断在扩充着的东西，为了保持/usr 的相对稳定，那些经常被修改的目录可以放在这个目录下，
	/etc 操作系统的配置文件目录。
	/usr/local 本地管理员安装的应用程序


 运行级别 3 完全的多用户(multiuser)状态 (有 NFS)，登陆后进入控制台命令行模式
 运行级别 5 X11 控制台 (xdm、gdm、kdm)，登陆后进入图形 GUI 模式

yum install -y xterm
yum install xorg-x11-apps
xclock

vim /etc/apt/sources.list
deb http://mirrors.aliyun.com/kali kali-rolling main non-free contrib
deb-src http://mirrors.aliyun.com/kali kali-rolling main non-free contrib
                                              
apt install open-vm-tools-desktop



​	