```
docker pull leishianquan/awvs-nessus:v03

docker run -itd -p 3443:3443 -p 8834:8834 leishianquan/awvs-nessus:v03

docker exec -it $(sudo docker ps |awk '/awvs/{print $1}') /bin/bash
```

/etc/init.d/nessusd start

https://ip:8834/

```
用户名是leishi，密码是leishianquan
```

