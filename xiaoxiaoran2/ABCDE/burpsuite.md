

	https://blog.csdn.net/qq_35544379/article/details/76696106
	
	https://blog.csdn.net/weixin_43639741/article/details/90440913
	
	https://t0data.gitbooks.io/burpsuite/content/chapter1.html



## 可以连续发相同的包
`	intruder -> payload -> payload type -> Null payloads `

## 目录扫描

​	`target -> site map-> engagement tools -> content discovery -> site map`

## 网站任意文件内容搜索

​	`target -> site map-> engagement tools -> search `

## 每次抓包自动添加一行

```shell
proxy -> options -> match and replace -> add 
		type = request header  match = null replace = X-Forwarded-or:1.1.1.1
```



## 验证码js替换

````
proxy -> options -> match and replace -> add 
		type = request body  match = xx:10 replace = xx:9999
````



## 可以自动生成4位数

````
intruder -> payload -> payload type -> numbers
		sequential 0 9999 1   decimal 4 4 0 0
````



## 添加宏,自动登录

```
project options -> sessions -> macros -> add ->  ctrl... -> test macro 
		-> sessions -> session handling rules -> add -> rule actions -> run a macro 
        ->scope -> url scope
```


## 当长度一样时
`	filter -> code: 'bugku10000' -> negative search`

## 自动生成字典

```
intruder -> payload -> payload type -> brute forcer
```



​	[宏,完成添加商品,使用优惠卡...](	https://portswigger.net/web-security/logic-flaws/examples/lab-logic-flaws-infinite-money)



[Burp Collaborator](https://blog.csdn.net/fageweiketang/article/details/89073662)

