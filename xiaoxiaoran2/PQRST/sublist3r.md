
## Sublist3r是一个用Python编写的子域发现工具
旨在使用来自公共资源和暴力技术的数据枚举网站的子域。公共资源包括广泛的流行搜索引擎

## 安装
```
git clone https://github.com/aboul3la/Sublist3r.git
pip3 install -r requirements.txt
python3 sublist3r.py
```
## 使用
```
-d	—domain	枚举子域名的域名
-b	—bruteforce	启用subbrute bruteforce模块
-p	—port	针对特定的TCP端口扫描找到的子域
-v	—verbose	启用详细模式并实时显示结果
-t	—threads	用于subbrute bruteforce的线程数
-e	—engines	指定以逗号分隔的搜索引擎列表
-o	—output	将结果保存到文本文件
-h	—help	显示帮助信息并退出
```

### 枚举特定域的子域
`python3 sublist3r.py -d example.com`

### 枚举特定域的子域并仅显示具有开放端口80和443的子域
`python3 sublist3r.py -d example.com -p 80,443`

### 枚举特定域的子域并实时显示结果
`python3 sublist3r.py -v -d example.com`

### 枚举子域并启用bruteforce模块并启动10个线程
`python3 sublist3r.py -b -d example.com -t 10`

### 枚举子域并使用特定引擎，例如Google，Yahoo和Virustotal引擎
`python3 sublist3r.py -e google,yahoo,virustotal -d example.com`
