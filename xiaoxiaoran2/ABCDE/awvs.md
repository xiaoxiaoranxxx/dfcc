[源](https://baynk.blog.csdn.net/article/details/118974734)




```shell
docker pull leishianquan/awvs-nessus:v03

docker run -itd -p 3443:3443 -p 8834:8834 leishianquan/awvs-nessus:v03

docker exec -it $(sudo docker ps |awk '/awvs/{print $1}') /bin/bash
```



### 注册awvs



``` sh
cp /home/license_info.json /home/acunetix/.acunetix/data/license/

```

`https://ip:3443/`



**用户名是  leishi@leishi.com**

**密码为   Leishi123**

