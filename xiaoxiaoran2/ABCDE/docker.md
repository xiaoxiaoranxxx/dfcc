

##教程

```
https://www.bilibili.com/video/BV1og4y1q7M4?from=search&seid=7049871918556279556
https://zhuanlan.zhihu.com/p/54147784
https://docs.docker.com/get-started/overview/
```

## 常用

```sh
docker pull kalilinux/kali   
docker run -p 4444:4444 -it 06d20309031e /bin/bash
docker run -p 4444:4444 -it -v /root/xiao:/home/xiao 06d20309031e /bin/bash
docker run -i -t 85d6f5766821  /bin/bash
docker pa -a
docker start af068c8e8abe
docker exec -it  af068c8e8abe /bin/bash
```

## 文件操作

```
docker cp af068c8e8abe:/root/xiao/1.txt /root/xiao
cp 1.txt /www/wwwroot/47.95.141.60/
```

## 删除

```
docker rmi -f id... 删镜像
docker rm id... 删容器
```



	systemctl start docker
	docker version
	docker run hello-world
	docker images --help
	docker search mysql --filter=STARS=3000
	docker pull mysql  = docker pull docker.io/library/mysql:latest
		docker pull mysql:5.7
	
	docker pull centos
	docker run [-xx] image
		--name="xiao"
		-d  后台运行
		-it 交互
		-p 端口
	docker run -it centos /bin/bash
	docker ps
		-a 所有
	ctrl + P + Q 退出不停值


​	
​	docker start id...
​	docker restart id...
​	docker stop id...
​	docker kill id...
​	
	docker logs -tf --tail 100  078fdfa5283a  查看日志
	docker top id.. 
	docker top 7ba0281c97c2   容器中的进程
	
	docker inspect id 查看容器元数据
	
	docker exec -it id /bin/bash 进入正在运行的容器
	docker attach id  不开启一个新的终端,进入正在执行的终端
	
	docker cp id:/home/test.txt  /home  从容器到主机
	
	docker stats 查看cpu的状态
	
	portainer 可视化工具
	
	联合文件系统	分层	y

##  实例

	nginx
		docker search nginx
		docker pull nginx
		docker run -d --name nginx01 -p 3344:80 nginx
		docker ps
		curl 127.0.0.1:3344
	tomcat
		docker run -it --rm tomcat:9.0   //测试
		docker run -d -p 3355:8080 --name tomcat01  tomcat
		docker exec -it tomcat01 tomcat /bin/bash  //只保证最小运行环境
	ES+kibana
		docker run -d --name elasticsearch -p 9200:9200 -p 9300:9300 -e "discovery.type=single-node" elasticsearch




docker commit -m="xx" -a="xiao" id  提交副本 类似快照

## 容器数据卷 

  数据持久化,数据共享 -> 同步操作,做文件映射

```
docker run -it -v /home/xiaoxiaoran:/home/centos_xiaoxiaoran  centos /bin/bash

		me->xiaoxiaoran == you->centos_xiaoxiaoran

			docker inspect 012fee9be225
				 "Mounts": 
					[{
						"Type": "bind",
						"Source": "/home/xiaoxiaoran",
						"Destination": "/home/centos_xiaoxiaoran",
						"Mode": "",
						"RW": true,
						"Propagation": "rprivate"
					}],
```

​	

	mysql 挂载
		docker run -d -p 3310:3306 -v /home/mysql/conf:/etc/mysql/conf.d -v /home/mysql/data:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=123456 --name mysql01 mysql:5.7
			ro 只读 rw读写
			
	docker volume ls
	
	docker run -d --name -v xiaoxiaoran-nginx:/etc/nginx nginx   具名挂载
		/var/lib/docker/volume/xiaoxiaoran/_data
		
	多容器同步  --volume-from  继承

## DockerFile

	#指令大写
	FROM 基础镜像
	MAINTAINER 作者
	RUN 运行命令
	ADD 添加
	WORKDIR	工作目录
	VOLUME 挂载
	EXPOSE 开放端口
	RUN  开始
	CMD  只有最后一个生效
	ENTRYPOINT 追加命令
	ONBUILD  继承
	CP   拷贝
	ENV 环境变量
		
	mydockerfile-centos
		FROM centos
		MAINTAINER xiaoxiaoran<66666@xiuxiu.com>
		ENV MYPATH /usr/local
		WORKDIR $MYPATH
		RUN yum -y install vim 
		RUN yum -y install net-tools
		EXPOSE 80
		CMD echo $MYPATH
		CMD echo "--->$*$<---"
		CMD /bin/bash
	docker build -f mydockerfile-centos -t mycentos:1.0
	
	docker history id  查看历史
	
	mydockerfile-tomcat //默认DockerFile
		FROM centos
		MAINTAINER xiaoxiaoran<66666@xiuxiu>
		COPY readme.txt /usr/local/readme.txt
		ADD jbk-8ull-linux-x64.tar.gz /usr/local   //自动解压
		ADD tomcat.tar.gz  /usr/local
		RUN yum -y install vim 
		RUN yum -y install net-tools
		ENV MYPATH /usr/local
		WORKDIR $MYPATH
		ENV JAVA_HOME /usr/localjdk1.8.0_11
		ENV CLASSPATH $JAVA_HOME/lib/dt.jar;$JAVA_HOME/lib/tools.jar
		ENV CATALINA_HOME /usr/local/apache-tomcat-9.0.22
		ENV CATALINA_BASH /usr/local/apache-tomcat-9.0.22
		ENV PATH $PATH;$JAVA_HOME/bin;$CATALINA_HOME/lib;$CATALINA_HOME/bin
		EXPOSE 8080
		CMD /usr/local/apache-tomcat-9.0.22/bin/startup.sh && tail -F /usr/local/apache-tomcat-9.0.22/bin/logs/catalina.out
	docker build -t mytomact .  
	
	docker login -u xiaoxiaoran 
	docker push xiaoxiaoran:tomcat:1.1 

## docker网络

### 主机

	docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
	link/ether 02:42:e9:f4:98:03 brd ff:ff:ff:ff:ff:ff
	inet 172.17.0.1/16 brd 172.17.255.255 scope global docker0
	   valid_lft forever preferred_lft forever
	inet6 fe80::42:e9ff:fef4:9803/64 scope link 
	   valid_lft forever preferred_lft forever  
	7: vethb7a6d3d@if6: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue master docker0 state UP group default 
	link/ether be:49:2d:bb:2a:72 brd ff:ff:ff:ff:ff:ff link-netnsid 1
	inet6 fe80::bc49:2dff:febb:2a72/64 scope link 
	   valid_lft forever preferred_lft forever


​	 

### kali

```
6: eth0@if7: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP group default 
	link/ether 02:42:ac:11:00:03 brd ff:ff:ff:ff:ff:ff link-netnsid 0
	inet 172.17.0.3/16 brd 172.17.255.255 scope global eth0
	   valid_lft forever preferred_lft forever
```

### 原理

```
kali -> 6: eth0@if7 -> 7: vethb7a6d3d@if6 -> docker0(路由器)	   
```




	桥接   evth-pair虚拟设备接口
	
	docker run -d -P --name kali02 --link kali01 kali 可以使用名字就可以互联
		docker exec -it kali02 cat /etc/hosts
			172.0.0.1 kali01 ewiuhfwuewgui 原理
		
	docker network ls
	
	自定义网络
	docker network create --driver bridge --subnet 192.168.0.0/16 --gateway 192.168.0.1 mynetname
	
	跨网络连通
	docker network connect mynetname kali02  一个容器,两个ip


​	
​	
​	