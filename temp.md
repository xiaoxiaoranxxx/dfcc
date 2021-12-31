# 图书信息查询系统

php5.5 + mysql5.6 + 宝塔面板 + Nginx免费防火墙 + Debian

# 网站首页

https://temp.xiaoxiaoran.top/  (用的我的子域名...)

![image-20211208215816573](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202112082158875.png)



## 首页 可以看到图书信息

![image-20211208220054529](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202112082200490.png)

> 上方点击相应的类别下发会显示相应书籍
>
> 具有分页效果

> https://temp.xiaoxiaoran.top/?pageno=4&titleid=2(采用get传参)

## sql注入

- 用的过时的php的mysql_connect
- 也没有用预处理
- 首页所有sql参数用addslashes() + utf-8编码



# 登录

https://temp.xiaoxiaoran.top/admin/

![image-20211208221019918](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202112082210186.png)



## 弱密码

> 为了方便测试  

用户名 : admin     密码: @admin

## 暴力破解

30秒请求20 封 99999秒



# 后台

![image-20211208221606165](https://xiuxiu-1306082599.cos.ap-beijing.myqcloud.com/xiao/202112082216307.png)

- 可以实现增删改,查(ctrl+f)
- 没有任何美化
- 没有任何安全加固

