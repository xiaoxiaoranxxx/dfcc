# curl

## 基本用法

```
curl http://www.baidu.com
```

## 保存访问的网页

```
重定向：
curl http://www.baidu.com >> linux.html

使用 -o 参数：
curl -o linux.html http://www.baidu.com

当然也可以使用 -O 参数保存网页中的文件（注意：一定要指定具体的文件）
curl -O http://www.baidu.com/hello.sh
```


## 指定proxy服务器以及其端口

```
curl -x 192.168.0.1:10086 http://www.baidu.com
```

## cookie

```
保存http的response里面的cookie信息。内置option：-c（小写）
curl -c cookie.txt http://www.baidu.com

执行之后，cookie信息就被保存到 cookie.txt 文件里面了。

保存http的response里面的header信息。内置option：-D
curl -D cookied.txt http://www.baidu.com

cookie使用
很多网站使用cookie去鉴定用户访问权限，curl通过内置option：-b
curl -b cookiec.txt http://www.baidu.com
```

## 测试网页返回值

```
curl -o /dev/null -s -w %{http_code} www.baidu.com
```

**url_effective 最终获取的url地址**，尤其是当你指定给curl的地址**存在****301跳转**，且通过**-L**继续追踪的情

**http_code http状态码**，如200成功, 301转向, 404未找到, 500服务器错误等。

**http_connect** The numerical code that was found in the last response (from a proxy) to a curl CONNECT request. (Added in 7.12.4)

**time_total** **总时间**，按秒计。精确到小数点后三位。

**time_namelookup DNS解析时间**, 从请求开始到DNS解析完毕所用时间。

**time_connect 连接时间**, 从开始到建立TCP连接完成所用时间, **包括前边DNS解析时间**，如果需要单纯的得到连接时间，用这个time_connect时间减去前边time_namelookup时间。

**time_appconnect** **连接建立完成时间**，如SSL/SSH等建立连接或者完成三次握手时间。

**time_pretransfer 从开始到准备传输的时间。**

**time_redirect** **重定向时间**，包括到最后一次传输前的几次重定向的DNS解析，连接，预传输，传输时间。

**time_starttransfer** **开始传输时间**。在 **发出请求** 之后，Web 服务器 **返回数据的第一个字节** 所用的时间.

**size_download** **下载大小**。(The total amount of bytes that were downloaded.)

**size_upload** **上传大小**。(The total amount of bytes that were uploaded.)

**size_header****下载的header的大小**(The total amount of bytes of the downloaded headers.)

**size_request** **请求的大小**。(The total amount of bytes that were sent in the HTTP request.)

**speed_download 下载速度，单位-字节每秒**。

**speed_upload 上传速度,单位-字节每秒**。(The average upload speed that curl measured for the complete upload. Bytes per second.)

**content_type** 就是**content-Type**，不多说，结果示例**(text/html; charset=UTF-8)**。

**num_connects** Number of new connects made in the recent transfer. (Added in 7.12.3)





