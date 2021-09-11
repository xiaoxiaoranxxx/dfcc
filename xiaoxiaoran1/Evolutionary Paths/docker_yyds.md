## Docker搭建sqli-labs环境

```
docker pull acgpiano/sqli-labs 

docker run -dt --name sqli -p 8844:80 -p 4306:3306

docker exec -it  b0148f4febbb /bin/bash

mysql>set password for root@localhost = password('root'); 

授权允许远程访问
grant all privileges on *.* to 'root'@'%' identified by 'root';
flush privileges; 

//关闭授权 revoke all on *.* from dba@localhost;

ctrl + P + Q 退出不停值
```

