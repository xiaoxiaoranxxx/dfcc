## ShadowSocks 是由@clowwindy所开发的一个开源 Socks5 代理
如其官网所言 ，它是 “A secure socks5 proxy, designed to protect your Internet traffic” （一个安全的 Socks5 代理）。

最受欢迎的翻墙方案前五名是： fqrouter 、goagent、shadowsocks、自由门、VPN；
最坚挺的翻墙方案前五名是：shadowsocks、fqrouter、自由门、VPN、路由器翻墙”。

## 安装
```
wget --no-check-certificate https://raw.githubusercontent.com/teddysun/shadowsocks_install/master/shadowsocksR.sh
chmod +x shadowsocksR.sh
./shadowsocksR.sh
```

## 配置
```
Your Server IP        :  47.95.141.60 
Your Server Port      :  9080 
Your Password         :  ************
Your Protocol         :  auth_chain_a 
Your obfs             :  http_simple 
Your Encryption Method:  chacha20-ietf 
```
## 客户端
```
https://github.com/shadowsocksrr/shadowsocksr-csharp/releases
```

Google BBR就是谷歌公司提出的一个开源TCP拥塞控制的算法。在最新的linux 4.9及以上的内核版本中已被采用。对于该算法的分析，ss不经过其它的任何的优化就能轻松的跑满带宽。一键安装BBR 只需下面一条命令
```
wget -N --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.h && chmod +x bbr.sh && bash bbr.sh
sysctl net.ipv4.tcp_congestion_control
	net.ipv4.tcp_congestion_control = bbr
```

配置局域网代理功能
右击ssr客户端，然后选择“选项设置”	局域网中其他主机只需要将浏览器中的代理设置指向开启SSR客户端的主机IP地址和端口即可访问。

