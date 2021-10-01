
## 这种代理方式是透明代理

## 安装

```
yum -y install tinyproxy 
```
## 配置

```
vim /etc/tinyproxy/tinyproxy.conf 

	23 Port 5555
	210 Allow 116.172.173.114


systemctl start tinyproxy.service 
systemctl enable tinyproxy.service 

curl -x 47.95.141.60:5555 ip.sb

```
