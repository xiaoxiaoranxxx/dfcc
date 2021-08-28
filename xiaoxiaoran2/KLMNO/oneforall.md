## OneForAll是一款功能强大的子域收集工具

```
git clone https://github.com.cnpmjs.org/shmilylty/OneForAll.git
pip3 install -r requirements.txt 
```

`python3 oneforall.py --target zhihu.com run`


```
DESCRIPTION
    OneForAll是一款功能强大的子域收集工具

    Example:
        python3 oneforall.py version
        python3 oneforall.py --target example.com run
        python3 oneforall.py --target ./domains.txt run
        python3 oneforall.py --target example.com --valid None run
        python3 oneforall.py --target example.com --brute True run
        python3 oneforall.py --target example.com --port small run
        python3 oneforall.py --target example.com --format csv run
        python3 oneforall.py --target example.com --dns False run
        python3 oneforall.py --target example.com --req False run
        python3 oneforall.py --target example.com --takeover False run
        python3 oneforall.py --target example.com --show True run

    Note:
        参数alive可选值True，False分别表示导出存活，全部子域结果
        参数port可选值有'default', 'small', 'large', 详见config.py配置
        参数format可选格式有'rst', 'csv', 'tsv', 'json', 'yaml', 'html',
                          'jira', 'xls', 'xlsx', 'dbf', 'latex', 'ods'
        参数path默认None使用OneForAll结果目录生成路径


    --brute=BRUTE
        使用爆破模块(默认False)
    --dns=DNS
        DNS解析子域(默认True)
    --req=REQ
        HTTP请求子域(默认True)
    --port=PORT
        请求验证子域的端口范围(默认只探测80端口)
    --valid=VALID
        只导出存活的子域结果(默认False)
    --format=FORMAT
        结果保存格式(默认csv)
    --path=PATH
        结果保存路径(默认None)
    --takeover=TAKEOVER
        检查子域接管(默认False)
```	
```		
baidu.com.csv是每个主域下的子域收集结果。

all_subdomain_result_1583034493.csv是每次运行OneForAll收集到子域的汇总结果，包含baidu.com.csv，方便在批量收集场景中获取全部结果。

result.sqlite3是存放每次运行OneForAll收集到子域的SQLite3结果数据库，其数据库结构如下图：

Database

其中类似baidu_com_origin_result表存放每个模块最初子域收集结果。

其中类似baidu_com_resolve_result表存放对子域进行解析后的结果。

其中类似baidu_com_last_result表存放上一次子域收集结果（需要收集两次以上才会生成）。

其中类似baidu_com_now_result表存放现在子域收集结果，一般情况关注这张表就可以了。
```