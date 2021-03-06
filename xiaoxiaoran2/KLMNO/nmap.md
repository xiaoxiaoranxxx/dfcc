```
sudo nmap -p 22 39.107.221.203                                                 
	22/tcp open  ssh

sudo nmap -p 22 39.107.221.203 -sS -sV
	22/tcp open  ssh     OpenSSH 7.4 (protocol 2.0)

sudo nmap  39.107.221.203  -O  
	Running: Microsoft Windows XP
```
```
sudo nmap  39.107.221.203  -A
	22/tcp   open  ssh     OpenSSH 7.4 (protocol 2.0)
	| ssh-hostkey: 
	|   2048 4e:5f:11:0f:69:93:7d:62:91:e6:f9:6e:08:2f:49:aa (RSA)
	|   256 81:b1:33:2d:e1:09:1a:fb:60:1e:68:df:39:38:39:ac (ECDSA)
	|_  256 4b:4b:63:49:8b:2f:f5:47:95:f6:be:54:97:d6:82:ea (ED25519)
	80/tcp   open  http    Apache httpd 2.4.39 ((Unix) OpenSSL/1.1.1b)
	| http-methods: 
	|_  Potentially risky methods: TRACE
	|_http-server-header: Apache/2.4.39 (Unix) OpenSSL/1.1.1b
	|_http-title: xiaoxiaoran
	9080/tcp open  glrpc?
	| fingerprint-strings: 
	|   FourOhFourRequest, GetRequest, HTTPOptions, RTSPRequest, SIPOptions: 
	|     HTTP/1.1 404 Not Found
	|     Content-Type: text/html;charset=utf-8
	|     Connection: keep-alive
	|     Server: xpserver/3.5.15
	|     Content-Length: 111
```
```
sudo nmap  39.107.221.203  -A -sS -oN ./1.txt

sudo nmap  39.107.221.203  --script=./home/vulscan.nse -oN 2.txt

sudo nmap 8.8.8.8 -n -T3 -sU -A

sudo nmap  -F 39.156.69.79 -D1.1.1.1,2.2.2.2

sudo nmap -iflist

sudo nmap  -F 39.156.69.79 -sT -sV

sudo nmap  -F 39.156.69.79 -sT -sV --spoof-mac 02:42:AC:11:00:02

sudo nmap --script ipidseq -iR 1000 -oN xiaiii.txt

sudo nmap -Pn -sI ip:port 1.1.1.1

```

Nmap突破防火墙扫描 常见思路
1、碎片扫描
nmap -f www.fujieace.com

nmap -mtu 8 www.fujieace.com
 

2、诱饵扫描
nmap -D RND:10 www.fujieace.com

nmap –D decoy1,decoy2,decoy3 www.fujieace.com
 

3、空闲扫描
nmap -P0 -sI zombie www.fujieace.com
 

4、随机数据长度
nmap --data-length 25 www.fujieace.com

nmap --randomize-hosts 103.17.40.69-100
 

5、欺骗扫描
nmap --sT -PN --spoof-mac aa:bb:cc:dd:ee:ff www.fujieace.com
nmap --badsum www.fujieace.com
nmap -g 80 -S www.baidu.com www.fujieace.com

nmap -p80 --script http-methods --script-args http.useragent=”Mozilla 5” www.fujieace.com

```
使用方法:nmap [Scan Type(s)] [Options] {target specification}
目标说明:
可以通过主机名，IP地址，网络等。
例如:scanme.nmap.org, microsoft.com/24, 192.168.0.1;10.0.0-255.1-254
-iL &lt;inputfilename&gt;:从主机/网络列表中输入
-iR &lt;num hosts&gt;:选择随机目标
——exclude &lt;host1[，host2][，host3]，…&gt;:排除主机/网络
——Exclude &lt;:排除文件列表
主人发现:
- sl:列表扫描-简单地列出要扫描的目标
-sn: Ping Scan - disable端口扫描
-Pn:将所有主机设置为在线——跳过主机发现
-PS/PA/PU/PY[portlist]: TCP SYN/ACK, UDP或SCTP发现给定端口
-PE/PP/PM: ICMP echo、时间戳和netmask请求发现探测
-PO[protocol list]: IP协议Ping
-n/-R: Never do DNS resolve /Always resolve[默认:有时]
——DNS -servers &lt;serv1[，serv2]，…&gt;:指定自定义DNS服务器
——system-dns:使用操作系统的DNS解析器
——traceroute:跟踪到每个主机的跳转路径
扫描技术:
-sS/sT/sA/sW/sM: TCP SYN/Connect()/ACK/Window/Maimon扫描
- su: UDP扫描
-sN/sF/sX: TCP Null、FIN和Xmas扫描
——scanflags &lt;flags&gt;:自定义TCP扫描标志
-sI &lt;僵尸主机[:probeport]&gt;:空闲扫描
-sY/sZ: SCTP INIT/COOKIE-ECHO扫描
-sO: IP协议扫描
-b &lt;FTP中继主机&gt;: FTP反弹扫描
端口规格及扫描顺序:
-p &lt;port ranges&gt;:只扫描指定的端口
例:第22位;p1 - 65535;T - p U: 53111137: 21 - 25日,80139年,8080年,史:9
——Exclude -ports &lt;port range &gt;:排除指定端口的扫描
- f:快速模式-扫描比默认扫描少的端口
-r:连续扫描端口-不要随机
——top-ports &lt;number&gt;:扫描&lt;最常见的港口
——port ratio &lt;ratio&gt;:扫描端口比&lt;
服务/版本检测:
-sV:探测打开的端口以确定服务/版本信息
——version-intensity &lt;level&gt;:设置从0(光)到9(尝试所有探头)
——version-light:限制最可能的探针(强度2)
——version-all:尝试每个探针(强度9)
——version-trace:显示详细版本扫描活动(用于调试)
脚本扫描:
-sC:等价于——script=default
——script=&lt;Lua scripts&gt;: &lt;是用逗号分隔的列表
目录、脚本文件或脚本类别
n1=v1，[n2=v2，…]&gt;:为脚本提供参数
——script-args-file=filename:在文件中提供NSE脚本参数
——script-trace:显示所有发送和接收的数据
——script-updatedb:更新脚本数据库。
——script-help=&lt;Lua scripts&gt;:显示脚本帮助。
           & lt; Lua scripts&gt;是用逗号分隔的脚本文件列表还是
            script-categories。
操作系统检测:
-O:开启OS检测
——osscan-limit:限制OS检测到有希望的目标
osscan-guess:更积极地猜测操作系统
时间和性能:
需要花费时间的选择是秒，或附加'ms'(毫秒)，
's'(秒)，'m'(分钟)，或'h'(小时)的值(例如30m)。
-T&lt;0-5&gt;:设置定时模板(越高越快)
——min-hostgroup/max-hostgroup &lt;size&gt;:并行扫描主机组大小
——min-parallelism/max-parallelism &lt;numprobes&gt;:探测并行度
——min-rtt-timeout / max-rtt-timeout initial-rtt-timeout & lt; time&gt:指定
探测器往返时间。
——max-retries &lt;tries&gt;:设置端口扫描探针重传的上限。
host-timeout &lt;time&gt;:在这么长时间后放弃目标
——scan-delay/——max-scan-delay &lt;time&gt;:调整探头之间的延迟
——min-rate &lt;number&gt;:发送包的速度不低于&lt;每秒
——max-rate &lt;number&gt;:发送数据包的速度不超过&lt;每秒
防火墙/ ids规避和欺骗:
- f;——mtu &lt;val&gt;:片段包(可选w/给定的mtu)
用诱骗物使扫描隐身
-S &lt;IP_Address&gt;:欺骗源地址
-e &lt;iface&gt;:使用指定的接口
-g/——source-port &lt;portnum&gt;:使用指定的端口号
——proxy &lt;url1，[url2]，…&gt;:通过HTTP/SOCKS4代理进行中继连接
——data &lt;十六进制字符串&gt;:在发送的数据包中添加自定义有效负载
——data-string &lt;string&gt;:在发送的数据包中附加一个自定义ASCII字符串
——data-length &lt;num&gt;:在发送的包中附加随机数据
——ip-options &lt;options&gt;:发送指定ip选项的报文
——ttl &lt;val&gt;:设置IP生存时间字段
——Spoof -mac &lt;mac地址/前缀/供应商名称&gt;:欺骗你的mac地址
——badsum:发送伪造TCP/UDP/SCTP校验和的报文
输出:
-oN/-oX/-oS/-oG &lt;: Output scan in normal, XML, s|&lt;rIpt kIddi3;
和Grepable格式，分别为给定的文件名。
-oA &lt;basename&gt;:同时输出三种主要格式
-v:增加详细级别(使用-vv或更大的效果)
-d:增加调试级别(使用-dd或更多以获得更好的效果)
——reason:显示端口处于特定状态的原因
——open:仅显示打开(或可能打开)端口
——packet-trace:显示所有发送和接收的报文
——iflist:打印主机接口和路由(用于调试)
——add -output:附加到指定的输出文件，而不是clobber
——resume &lt;filename&gt;:恢复已中止的扫描
——stylesheet &lt;path/URL&gt;:将XML输出转换为HTML的XSL样式表
——webxml:从Nmap引用样式表。Org用于更可移植的XML
——no-stylesheet:防止将XSL样式表与XML输出相关联
MISC:
-6:开启IPv6扫描
-A:开启OS检测、版本检测、脚本扫描和traceroute功能
——datadir &lt;dirname&gt;:指定自定义Nmap数据文件位置
——Send -eth/——Send - IP:使用原始以太网帧或IP包发送
——privileged:假设用户完全有特权
——unprivileged:假设用户缺乏原始套接字特权
-V:打印版本号
-h:打印帮助摘要页面。
例子:
nmap -v -A
nmap -v -sn 192.168.0.0/16 10.0.0.0/8
nmap -v -iR 10000 -Pn -p 80
更多选项和例子，请参阅手册页(https://nmap.org/book/man.html)
```

```
Nmap 7.91 ( https://nmap.org )
Usage: nmap [Scan Type(s)] [Options] {target specification}                                     
TARGET SPECIFICATION:
  Can pass hostnames, IP addresses, networks, etc.                                                   
  Ex: scanme.nmap.org, microsoft.com/24, 192.168.0.1; 10.0.0-255.1-254
  -iL <inputfilename>: Input from list of hosts/networks                                                   
  -iR <num hosts>: Choose random targets                                                   
  --exclude <host1[,host2][,host3],...>: Exclude hosts/networks                                                   
  --excludefile <exclude_file>: Exclude list from file
HOST DISCOVERY:
  -sL: List Scan - simply list targets to scan
  -sn: Ping Scan - disable port scan
  -Pn: Treat all hosts as online -- skip host discovery                                                   
  -PS/PA/PU/PY[portlist]: TCP SYN/ACK, UDP or SCTP discovery to given ports
  -PE/PP/PM: ICMP echo, timestamp, and netmask request discovery probes
  -PO[protocol list]: IP Protocol Ping
  -n/-R: Never do DNS resolution/Always resolve [default: sometimes]
  --dns-servers <serv1[,serv2],...>: Specify custom DNS servers
  --system-dns: Use OS's DNS resolver
  --traceroute: Trace hop path to each host
SCAN TECHNIQUES:
  -sS/sT/sA/sW/sM: TCP SYN/Connect()/ACK/Window/Maimon scans
  -sU: UDP Scan
  -sN/sF/sX: TCP Null, FIN, and Xmas scans
  --scanflags <flags>: Customize TCP scan flags
  -sI <zombie host[:probeport]>: Idle scan
  -sY/sZ: SCTP INIT/COOKIE-ECHO scans
  -sO: IP protocol scan
  -b <FTP relay host>: FTP bounce scan
PORT SPECIFICATION AND SCAN ORDER:
  -p <port ranges>: Only scan specified ports
    Ex: -p22; -p1-65535; -p U:53,111,137,T:21-25,80,139,8080,S:9
  --exclude-ports <port ranges>: Exclude the specified ports from scanning
  -F: Fast mode - Scan fewer ports than the default scan
  -r: Scan ports consecutively - don't randomize
  --top-ports <number>: Scan <number> most common ports
  --port-ratio <ratio>: Scan ports more common than <ratio>
SERVICE/VERSION DETECTION:
  -sV: Probe open ports to determine service/version info
  --version-intensity <level>: Set from 0 (light) to 9 (try all probes)
  --version-light: Limit to most likely probes (intensity 2)
  --version-all: Try every single probe (intensity 9)
  --version-trace: Show detailed version scan activity (for debugging)
SCRIPT SCAN:
  -sC: equivalent to --script=default
  --script=<Lua scripts>: <Lua scripts> is a comma separated list of
           directories, script-files or script-categories
  --script-args=<n1=v1,[n2=v2,...]>: provide arguments to scripts
  --script-args-file=filename: provide NSE script args in a file
  --script-trace: Show all data sent and received
  --script-updatedb: Update the script database.
  --script-help=<Lua scripts>: Show help about scripts.
           <Lua scripts> is a comma-separated list of script-files or
           script-categories.
OS DETECTION:
  -O: Enable OS detection
  --osscan-limit: Limit OS detection to promising targets
  --osscan-guess: Guess OS more aggressively
TIMING AND PERFORMANCE:
  Options which take <time> are in seconds, or append 'ms' (milliseconds),
  's' (seconds), 'm' (minutes), or 'h' (hours) to the value (e.g. 30m).
  -T<0-5>: Set timing template (higher is faster)
  --min-hostgroup/max-hostgroup <size>: Parallel host scan group sizes
  --min-parallelism/max-parallelism <numprobes>: Probe parallelization
  --min-rtt-timeout/max-rtt-timeout/initial-rtt-timeout <time>: Specifies
      probe round trip time.
  --max-retries <tries>: Caps number of port scan probe retransmissions.
  --host-timeout <time>: Give up on target after this long
  --scan-delay/--max-scan-delay <time>: Adjust delay between probes
  --min-rate <number>: Send packets no slower than <number> per second
  --max-rate <number>: Send packets no faster than <number> per second
FIREWALL/IDS EVASION AND SPOOFING:
  -f; --mtu <val>: fragment packets (optionally w/given MTU)
  -D <decoy1,decoy2[,ME],...>: Cloak a scan with decoys
  -S <IP_Address>: Spoof source address
  -e <iface>: Use specified interface
  -g/--source-port <portnum>: Use given port number
  --proxies <url1,[url2],...>: Relay connections through HTTP/SOCKS4 proxies
  --data <hex string>: Append a custom payload to sent packets
  --data-string <string>: Append a custom ASCII string to sent packets
  --data-length <num>: Append random data to sent packets
  --ip-options <options>: Send packets with specified ip options
  --ttl <val>: Set IP time-to-live field
  --spoof-mac <mac address/prefix/vendor name>: Spoof your MAC address
  --badsum: Send packets with a bogus TCP/UDP/SCTP checksum
OUTPUT:
  -oN/-oX/-oS/-oG <file>: Output scan in normal, XML, s|<rIpt kIddi3,
     and Grepable format, respectively, to the given filename.
  -oA <basename>: Output in the three major formats at once
  -v: Increase verbosity level (use -vv or more for greater effect)
  -d: Increase debugging level (use -dd or more for greater effect)
  --reason: Display the reason a port is in a particular state
  --open: Only show open (or possibly open) ports
  --packet-trace: Show all packets sent and received
  --iflist: Print host interfaces and routes (for debugging)
  --append-output: Append to rather than clobber specified output files
  --resume <filename>: Resume an aborted scan
  --stylesheet <path/URL>: XSL stylesheet to transform XML output to HTML
  --webxml: Reference stylesheet from Nmap.Org for more portable XML
  --no-stylesheet: Prevent associating of XSL stylesheet w/XML output
MISC:
  -6: Enable IPv6 scanning
  -A: Enable OS detection, version detection, script scanning, and traceroute
  --datadir <dirname>: Specify custom Nmap data file location
  --send-eth/--send-ip: Send using raw ethernet frames or IP packets
  --privileged: Assume that the user is fully privileged
  --unprivileged: Assume the user lacks raw socket privileges
  -V: Print version number
  -h: Print this help summary page.
EXAMPLES:
  nmap -v -A scanme.nmap.org
  nmap -v -sn 192.168.0.0/16 10.0.0.0/8
  nmap -v -iR 10000 -Pn -p 80
SEE THE MAN PAGE (https://nmap.org/book/man.html) FOR MORE OPTIONS AND EXAMPLES

```