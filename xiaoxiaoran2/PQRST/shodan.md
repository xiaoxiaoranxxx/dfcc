## 安装
```
$ easy_install shodan
pip install shodan
```
```
shodan host 39.107.221.203
	39.107.221.203
	City:                    Beijing
	Country:                 China
	Organization:            Aliyun Computing Co., LTD
	Updated:                 2021-07-31T12:26:37.976525
	Number of open ports:    1
	Vulnerabilities:         CVE-2019-1552  CVE-2019-1543   CVE-2019-0190

	Ports: 
		 80/tcp Apache httpd (2.4.39)
```
```
shodan honeyscore 39.107.221.203

shodan host  39.107.221.203 --history
 
shodan search "authentication disabled" port:5900

shodan search --limit 10 --fields ip_str,port http.title:hack by country:cn

shodan search --fields ip_str,port,org,hostnames apache --limit 10

shodan download result apache

shodan parse --fields ip_str,port,org --separator , result.json.gz

shodan stats vuln:cve-2019-0708

shodan stats --facets org:20 vuln:cve-2019-0708 tag:cloud

```